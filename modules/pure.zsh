#!/usr/bin/env zsh

fpath+=("$BASHTHINGS_MODULES/pure")
autoload -U promptinit
promptinit

# set colors
zstyle :prompt:pure:path color '#5BD4FF'
