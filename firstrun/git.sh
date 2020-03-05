#!/usr/bin/env bash

bgecho '--- Enabling GIT superpush ---'
git config --global alias.ultrapush '!git remote | xargs -L1 git push --all'
git config --global alias.superpush '!git remote | xargs -L1 git push'

bgecho '--- Enabling recursive clone ---'
git config --global alias.superclone 'clone --recurse-submodules'
git config --global alias.supermodule 'submodule add --recurse-submodules'
