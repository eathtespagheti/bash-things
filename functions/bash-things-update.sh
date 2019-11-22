#!/usr/bin/env bash

echo "Upgrading bash-things"
git -C $HOME/.bash_things pull

echo "Upgrading trueline"
git -C $HOME/.bash_things/trueline pull