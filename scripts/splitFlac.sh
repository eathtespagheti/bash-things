#!/usr/bin/env bash

[ ! "$(command -v shnsplit)" ] && echo "shntool missing" && return 3
[ ! "$(command -v cuetag.sh)" ] && echo "cuetool missing" && return 3

for file in "$@"; do
    if [ -f "$file" ]; then
        extension="${file##*.}"
        filenameNoExtension="${file%.$extension}"

        if [ "$extension" = "cue" ]; then
            cueFile="$file"
            flacFile="$filenameNoExtension.flac"
        elif [ "$extension" = "flac" ]; then
            flacFile="$file"
            cueFile="$filenameNoExtension.cue"
        fi
    else
        flacFile="$file.flac"
        cueFile="$file.cue"
    fi

    [ ! -f "$flacFile" ] && echo "flac not found" && return 1
    [ ! -f "$cueFile" ] && echo "cue not found" && return 2

    [ ! -d "split" ] && mkdir "split"
    shnsplit -f "$cueFile" -t "%n - %t" -d "split" -o flac "$flacFile"
    cuetag.sh "$cueFile" split/*
done
