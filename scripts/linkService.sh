#!/usr/bin/env sh

SYSTEMD_FOLDER="/lib/systemd/system"

# Check if script exist
[ ! -f "$BASHTHINGS_SERVICES/$1" ] && echo "Service $1 not found" && exit 2

# Check if link exist
[ -f "$SYSTEMD_FOLDER/$1" ] && rm "$SYSTEMD_FOLDER/$1"
# Make link
chmod +x "$BASHTHINGS_SERVICES/$1" && ln -s "$BASHTHINGS_SERVICES/$1" "$SYSTEMD_FOLDER/$1"
