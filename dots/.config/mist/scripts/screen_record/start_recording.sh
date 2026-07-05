#!/usr/bin/env bash

RECORD_AUDIO=${1:-"true"}
OUTPUT_DIR="$HOME/Videos"

mkdir -p "$OUTPUT_DIR"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
FILENAME="$OUTPUT_DIR/Recording_$TIMESTAMP.mp4"

if [ "$RECORD_AUDIO" == "true" ]; then
    gpu-screen-recorder -w screen -f 60 -a default_output -ac aac -o "$FILENAME" &
else
    gpu-screen-recorder -w screen -f 60 -o "$FILENAME" &
fi
