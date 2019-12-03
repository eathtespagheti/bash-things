#!/usr/bin/env zsh

# pure loading
fpath+=("$bashthingsModules/pure")
autoload -U promptinit
promptinit
zstyle :prompt:pure:path color '#5BD4FF'
prompt pure
