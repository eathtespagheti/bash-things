#!/usr/bin/env bash
# shellcheck disable=SC1090

# Check completions folder
[ -z "$COMPLETIONS_FOLDER" ] && COMPLETIONS_FOLDER="$BASHTHINGS_SCRIPTS/completions"

for file in $COMPLETIONS_FOLDER/*.bash; do
    source "$file"
done 
