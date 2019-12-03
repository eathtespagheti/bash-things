#!/usr/bin/env zsh

fpath+=("$bashthingsModules/pure")
autoload -U promptinit
promptinit

# set colors
zstyle :prompt:pure:path color '#5BD4FF'
