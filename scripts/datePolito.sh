#!/usr/bin/env sh

for file in "$@"; do
    date="$(echo "$file" | cut -d ' ' -f 3)"
    month="$(echo "$date" | cut -c 3-4)"
    day="$(echo "$date" | cut -c 1-2)"
    newdate="$month$day"
    newname="$(echo "$file" | sed "s/$date/$newdate/")"
    echo "from $file to $newname"
    mv "$file" "$newname"
done
