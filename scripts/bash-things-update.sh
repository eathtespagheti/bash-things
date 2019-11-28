#!/usr/bin/env bash

gecho "Updating bash-things"
git -C $bashthingsFolder pull
echo

gecho "Last 5 commits were"
git -C $bashthingsFolder log -n 5 --format=oneline
echo

gecho "Updating trueline"
git -C $bashthingsModules/trueline pull

gecho "Updating webhook"
git -C $bashthingsScripts/webhook pull
