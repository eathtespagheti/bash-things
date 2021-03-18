#!/usr/bin/env sh

for file in "$@"; do
    date="$(echo "$file" | cut -d ' ' -f 3)"
    year="$(echo "$date" | cut -c 5-8)"
    month="$(echo "$date" | cut -c 3-4)"
    day="$(echo "$date" | cut -c 1-2)"
    newdate="$year$month$day"
    newname="$(echo "$file" | sed "s/$date/$newdate/")"
    echo "$newname"
done
