#!/usr/bin/env sh
# shellcheck disable=SC1091

[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME="$HOME"/.config
[ -z "$XDG_CONFIG_DIRS" ] && export XDG_CONFIG_DIRS="$XDG_CONFIG_HOME" || export XDG_CONFIG_DIRS=:"$XDG_CONFIG_HOME"
[ -z "$XDG_DATA_HOME" ] && export XDG_DATA_HOME="$HOME"/.local/share
[ -z "$XDG_CACHE_HOME" ] && export XDG_CACHE_HOME="$HOME"/.cache

# load variables
[ -z "$BASHTHINGS_FOLDER" ] && export BASHTHINGS_FOLDER="$XDG_CONFIG_HOME"/bash_things
. "$BASHTHINGS_FOLDER"/modules/variables.sh

# docker configuration
[ -f "/etc/bash_completion.d/docker-machine-prompt.bash" ] && "$BASHTHINGS_MODULES"/docker.bash

# custom alias
. "$BASHTHINGS_MODULES"/alias.sh

# Check OS
. "$BASHTHINGS_FUNCTIONS"/checkOS.sh
# shellcheck disable=SC3028

case "$OSTYPE" in
    linux*)
        . "$BASHTHINGS_FOLDER"/linux.sh
    ;;
    darwin)
        . "$BASHTHINGS_FOLDER"/macOS.zsh
    ;;
    *)
        . "$BASHTHINGS_FOLDER"/basic.bash
    ;;
esac