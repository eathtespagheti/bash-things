#!/usr/bin/env sh

gecho "Updating bash-things"
git -C "$BASHTHINGS_FOLDER" pull
echo

gecho "Last 5 commits were"
git -C "$BASHTHINGS_FOLDER" log -n 5 --format=oneline
echo

gecho "Update submodules"
git -C "$BASHTHINGS_FOLDER" submodule update --init --recursive
