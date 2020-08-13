#!/usr/bin/env sh

while ! youtube-dl "$@" -c --socket-timeout 5; do
    echo "DISCONNECTED"
done
