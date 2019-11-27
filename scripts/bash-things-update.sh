#!/usr/bin/env bash

echo "Updating bash-things"
git -C $bashthingsFolder pull
echo

echo "Last 5 commits were"
git -C $bashthingsFolder log -n 5 --format=oneline
echo

echo "Updating trueline"
git -C $bashthingsFolder/trueline pull
