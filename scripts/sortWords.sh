#!/usr/bin/env sh

wordsString=""
for word in "$@"; do
    wordsString="$wordsString $word"
done

sortedString="$(echo "$wordsString" | tr ' ' '\n' | sort | tr '\n' ' ' | sed 's|^[[:space:]]*||;s|[[:space:]]*$||' )"
echo "$sortedString"
# Copy to clipboard if wl-copy exist
[ "$(command -v wl-copy)" ] && wl-copy "$sortedString"