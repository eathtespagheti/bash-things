#!/usr/bin/env bash

bgecho '--- Enabling GIT superpush ---'
git config --global alias.ultrapush '!git remote | xargs -L1 git push --all'
git config --global alias.superpush '!git remote | xargs -L1 git push'