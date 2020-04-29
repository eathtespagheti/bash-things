#!/usr/bin/env sh

links="$(pastebinit "$@")"
echo "$links" | wl-copy
echo "$links"
