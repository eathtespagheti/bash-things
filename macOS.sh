#!/usr/bin/env zsh

# pure loading
fpath+=("$bashthingsModules/pure")
autoload -U promptinit
promptinit
prompt pure
