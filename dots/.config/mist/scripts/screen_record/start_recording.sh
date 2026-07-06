#!/usr/bin/env bash

RECORD_AUDIO=${1:-"true"}
QUALITY=${2:-"very_high"}   # accepted values: "medium", "high", "very_high",  "ultra"
OUTPUT_DIR="$HOME/Videos"

mkdir -p "$OUTPUT_DIR"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
FILENAME="$OUTPUT_DIR/Recording_$TIMESTAMP.mp4"

if [ "$RECORD_AUDIO" == "true" ]; then
    gpu-screen-recorder -w screen -f 60 -q "$QUALITY" -a default_output -ac aac -o "$FILENAME" &
else
    gpu-screen-recorder -w screen -f 60 -q "$QUALITY" -o "$FILENAME" &
fi
