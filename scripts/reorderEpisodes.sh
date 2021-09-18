#!/usr/bin/env sh

for file in *.nfo; do
    [ ! "$file" = "season.nfo" ] && {
        filesList="$(printf "%s\n%s" "$filesList" "$file")"
    }
done

episode=1
echo "$filesList" | sort | tail -n +2 | while IFS= read -r file; do
    [ -f "$file" ] && {
        sed -ri "s/(<episode>).*(<\/episode>)/\1$episode\2/g" "$file"
        episode=$((episode + 1))
    }
done
