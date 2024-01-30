#!/bin/bash

exercises=("Grab" "Bridge" "Squat")
index=0

send_notification() {
    local exercise=$1
    notify-send --icon=face-surprise --expire-time=900000 --urgency critical --action="Continue" "Time to exercise! $exercise" "Do the $exercise exercise and click on Continue after you finished"
}

while true; do
    sleep 1800
    send_notification "${exercises[$index]}"
    index=$(( (index + 1) % 3 ))
done

