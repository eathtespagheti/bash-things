#!/usr/bin/env sh

season="$1"
[ -z "$season" ] && season="1"

for file in *.nfo; do
    [ ! "$file" = "season.nfo" ] && sed -ri "s/(<season>).*(<\/season>)/\1$season\2/g" "$file"
done
