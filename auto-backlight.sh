#!/bin/bash

# Run "ddccontrol -p" to probe your monitors
monitorId=3
address=0x10

# Get the current hour in 24-hour format
hour=$(date +%H)

# Define the brightness values for each hour
case $hour in
    18) brightness=60;;
    19) brightness=40;;
    20) brightness=20;;
    21|22|23|00|01|02|03|04|05) brightness=0;;
    *) brightness=100;;
esac

# Set the brightness using ddccontrol
ddccontrol -r $address -w $brightness dev:/dev/i2c-$monitorId
