#!/usr/bin/env sh

submoduleName=${1%/}
git submodule deinit -f -- "$submoduleName"
rm -rf .git/modules/"$submoduleName"
git rm -f "$submoduleName"
