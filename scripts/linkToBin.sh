#!/usr/bin/env sh

# Create bin name
binName=$(echo "$1" | cut -f 1 -d '.')
[ -z "$binName" ] && echo "Unable to parse the scriptname" && exit 1

# Check if script exist
[ ! -f "$BASHTHINGS_SCRIPTS/$1" ] && echo "Script $1 not found" && exit 2

# Make link
cd "$BASHTHINGS_BIN" || exit 1
chmod +x "../$1" && ln -f -s "../$1" "$binName"
