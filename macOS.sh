#!/usr/bin/env zsh

# case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# zsh-completion
fpath=(/usr/local/share/zsh-completions $fpath)

# syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# pure loading
source $bashthingsModules/pure.sh
prompt pure

# initialize completions
autoload -Uz compinit
compinit
