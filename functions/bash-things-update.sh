#!/usr/bin/env bash

echo "Updating bash-things"
git -C $HOME/.bash_things pull

echo "Updating trueline"
git -C $HOME/.bash_things/trueline pull