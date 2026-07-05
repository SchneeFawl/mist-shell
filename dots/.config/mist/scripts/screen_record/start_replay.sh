#!/usr/bin/env bash

RECORD_AUDIO=${1:-"true"}
REPLAY_TIME=${2:-60}

OUTPUT_DIR="$HOME/Videos"
mkdir -p "$OUTPUT_DIR"

if [ "$RECORD_AUDIO" == "true" ]; then
    gpu-screen-recorder -w screen -f 60 -a default_output -r "$REPLAY_TIME" -o "$OUTPUT_DIR" &
else
    gpu-screen-recorder -w screen -f 60 -r "$REPLAY_TIME" -o "$OUTPUT_DIR" &
fi
