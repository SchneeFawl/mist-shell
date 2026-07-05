#!/usr/bin/env bash

pkill -SIGINT -f gpu-screen-recorder
notify-send "Screen Recorder" "Recording saved to ~/Videos" -i video-x-generic
