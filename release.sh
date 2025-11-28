#!/bin/bash

# Save the current directory where the script is executed (the directory when starting the script)
START_DIR="$(pwd)/confs"

# If the directory exists, clear it; if not, create it
if [ -d "$START_DIR" ]; then
  rm -rf "$START_DIR"/*
else
  mkdir -p "$START_DIR"
fi

# Set the base directory to data/confs (relative to the script execution path, can also be an absolute path)
BASE_DIR="./data/confs"

# Check if the base directory exists
if [ ! -d "$BASE_DIR" ]; then
  echo "Directory does not exist: $BASE_DIR"
  exit 1
fi

# Traverse subdirectories under the base directory without changing the current working directory
for dir in "$BASE_DIR"/*/; do
  # dir is a path like "./data/confs/mk_mini/"

  # Get the directory name part, removing the trailing slash and path
  dirname="$(basename "${dir%/}")"

  # Construct the full path of the zip file to be generated, in the script's starting directory
  zipfile="${START_DIR}/${dirname}.zip"

  # If the zip file already exists, overwrite it (or you can choose to skip)
  if [ -f "$zipfile" ]; then
    echo "Zip file already exists and will be overwritten: $zipfile"
    rm "$zipfile"
  fi

  echo "Packing directory '$dir' -> '$zipfile'"
  # zip -r to compress
  zip -r "$zipfile" "$dir"
done

echo "All subdirectories have been packed."
