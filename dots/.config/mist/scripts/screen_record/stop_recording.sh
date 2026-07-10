#!/usr/bin/env bash

pkill -SIGINT -f gpu-screen-recorder
sleep 0.5
notify-send "Screen Recorder" "Recording saved to ~/Videos" -i video-x-generic
