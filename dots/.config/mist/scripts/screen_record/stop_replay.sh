#!/usr/bin/env bash

killall -SIGINT gpu-screen-recorder
sleep 0.5
notify-send "Screen Recorder" "Replay Buffer stopped" -i video-x-generic
