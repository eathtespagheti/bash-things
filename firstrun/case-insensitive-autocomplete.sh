#!/usr/bin/env sh

# If ~./inputrc doesn't exist yet, first include the original /etc/inputrc so we don't override it
[ ! -f "$INPUTRC" ] && {
    bashthingsLogger "$INPUTRC not found"
    directory="$(dirname "$INPUTRC")"
    # If directory doesn't exist
    [ ! -d "$directory" ] && mkdir -p "$directory" && bashthingsLogger "mkdir on $directory"
    # Create file
    bashthingsLogger "Generating $INPUTRC"
    echo "\$include /etc/inputrc" >"$INPUTRC"
}

bgecho 'Enabling case insensitive auto-complete...'
bashthingsLogger 'Enabling case insensitive auto-complete...'
echo "set completion-ignore-case On" >>"$INPUTRC"
