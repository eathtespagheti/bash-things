#!/usr/bin/env sh

gecho "Updating bash-things"
git -C "$BASHTHINGS_FOLDER" pull
echo

gecho "Last 5 commits were"
git -C "$BASHTHINGS_FOLDER" log -n 5 --format=oneline
echo

gecho "Update submodules"
git -C "$BASHTHINGS_FOLDER" submodule update --init --recursive

# gecho "Updating trueline"
# git -C $BASHTHINGS_MODULES/trueline pull

# gecho "Updating webhook"
# git -C $BASHTHINGS_SCRIPTS/webhook pull

# gecho "Updating pure"
# git -C $BASHTHINGS_MODULES/pure pull
