#!/usr/bin/env sh

# Create bin name
binName=$(echo "$1" | cut -f 1 -d '.')
[ -z "$binName" ] && echo "Unable to parse the scriptname" && exit 1

# Check if script exist
[ ! -f "$BASHTHINGS_SCRIPTS/$1" ] && echo "Script $1 not found" && exit 2

# Check if link exist
[ -f "$BASHTHINGS_BIN/$binName" ] && rm "$BASHTHINGS_BIN/$binName"
# Make link
chmod +x "$BASHTHINGS_SCRIPTS/$1" && ln -s "$BASHTHINGS_SCRIPTS/$1" "$BASHTHINGS_BIN/$binName"
