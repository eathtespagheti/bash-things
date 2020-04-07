#!/usr/bin/env bash
# shellcheck disable=SC2045

files=""
for item in $(ls "$BASHTHINGS_SCRIPTS"); do
    [ -f "$BASHTHINGS_SCRIPTS/$item" ] && files="$files $item"
done

[ -n "$BASHTHINGS_SCRIPTS" ] && complete -W "$files" linkToBin
