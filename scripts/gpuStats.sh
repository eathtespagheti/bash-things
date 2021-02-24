#!/usr/bin/env sh

time="$1"
[ -z "$time" ] && time=1

while true; do
    buffer=$(clear && sensors | head -n 6)
    echo "$buffer"
    sleep "$time"s
done
