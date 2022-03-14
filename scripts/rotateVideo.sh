#!/usr/bin/env sh

# Get name without extension
NAME=$(basename "$1" | sed "s/\.[^.]*$//")
# Get extension
EXTENSION=$(basename "$1" | sed "s/^[^.]*\.//")

[ -z "$2" ] && ROTATION=90 || ROTATION=$2

ffmpeg -i "$1" -c copy -metadata:s:v:0 rotate="$ROTATION" "$NAME"_rotated."$EXTENSION"