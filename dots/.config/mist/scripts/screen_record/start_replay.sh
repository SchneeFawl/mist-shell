#!/usr/bin/env bash

RECORD_AUDIO=${1:-"true"}
REPLAY_TIME=${2:-60}
QUALITY=${3:-"very_high"}   # accepted values: "medium", "high", "very_high",  "ultra"
COLOR_RANGE=${4:-"limited"}
FPS=${5:-60}

OUTPUT_DIR="$HOME/Videos"
mkdir -p "$OUTPUT_DIR"

if [ "$RECORD_AUDIO" == "true" ]; then
    gpu-screen-recorder -w screen -f "$FPS" -cr "$COLOR_RANGE" -q "$QUALITY" -a default_output -c mp4 -r "$REPLAY_TIME" -o "$OUTPUT_DIR" &
else
    gpu-screen-recorder -w screen -f "$FPS" -cr "$COLOR_RANGE" -q "$QUALITY" -r "$REPLAY_TIME" -o "$OUTPUT_DIR" &
fi
