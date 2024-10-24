#!/bin/bash

exercises=("Grab" "Bridge" "Squat")
index=0

send_notification() {
    local exercise=$1
    notify-send --icon=face-surprise --expire-time=900000 --urgency critical --action "I'm a fucking bitch.." --action="POWER!!!" "Time to exercise! $exercise" "Do the $exercise exercise and don't be a bitch!"
}

while true; do
    sleep 1800
    send_notification "${exercises[$index]}"
    index=$(( (index + 1) % 3 ))
done

