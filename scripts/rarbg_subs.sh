#!/usr/bin/env sh

for episode in "$@"; do
    ext="$(echo "$episode" | tr '.' ' ' | tr ' ' '\n' | tail -1)"
    noext="$(basename "$episode" ".$ext")"

    subs_folder="Subs/$noext"
    first_sub="$(find "$subs_folder" -iname "*.srt" | sort | head -1)"

    cp "$first_sub" "$noext.default.srt"
done