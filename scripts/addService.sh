#!/usr/bin/env sh

SYSTEMD_FOLDER="/etc/systemd/system"

# Create service name
serviceName=$(echo "$1" | cut -f 1 -d '.')
[ -z "$serviceName" ] && echo "Unable to parse the service name" && exit 1

# Check if script exist
[ ! -f "$BASHTHINGS_SERVICES/$1" ] && echo "Service $1 not found" && exit 2

# Check if link exist
[ -f "$SYSTEMD_FOLDER/$serviceName" ] && rm "$SYSTEMD_FOLDER/$serviceName"
# Make link
chmod +x "$BASHTHINGS_SERVICES/$1" && ln -s "$BASHTHINGS_SERVICES/$1" "$SYSTEMD_FOLDER/$serviceName"
