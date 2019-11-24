#!/usr/bin/env bash

echo "Updating bash-things"
git -C $HOME/.bash_things pull
echo

echo "Last 5 commits were"
git -C $HOME/.bash_things log -n 5 --format=oneline
echo

echo "Updating trueline"
git -C $HOME/.bash_things/trueline pull
