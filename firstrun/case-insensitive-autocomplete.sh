#!/usr/bin/env sh

# If ~./inputrc doesn't exist yet, first include the original /etc/inputrc so we don't override it
[ ! -f "$INPUTRC" ] && {
    directory="$(dirname "$INPUTRC")"
    # If directory doesn't exist
    [ ! -d "$directory" ] && mkdir -p "$directory"
    # Create file
    echo "\$include /etc/inputrc" >"$INPUTRC"
}

bgecho 'Enabling case insensitive auto-complete...'
echo "set completion-ignore-case On" >>"$INPUTRC"
