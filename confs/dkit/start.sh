#!/bin/bash

# gnss device
sudo chmod 777 /dev/ttyACM0

# canbus device
sudo chmod 777 /dev/ttyACM1
sudo emucd_64 -s7 /dev/ttyACM1 can0 can1
