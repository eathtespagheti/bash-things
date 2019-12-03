#!/usr/bin/env zsh

# zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)

# syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# pure loading
source $bashthingsModules/pure.sh
prompt pure
