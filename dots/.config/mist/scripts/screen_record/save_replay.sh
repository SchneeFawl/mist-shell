#!/usr/bin/env bash

pkill -SIGUSR1 -f gpu-screen-recorder
notify-send "Screen Recorder" "Replay saved to ~/Videos" -i video-x-generic
