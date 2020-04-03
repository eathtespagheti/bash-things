#!/usr/bin/env sh
# shellcheck disable=SC1090

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

# ls theme
[ -n "$LS_THEME" ] && load_themes

# Check OS
. "$BASHTHINGS_FUNCTIONS"/checkOS.sh
# shellcheck disable=SC2154,SC2039
if [ "$OSTYPE" = "linux-gnu" ]; then
    . "$BASHTHINGS_FOLDER"/linux.sh
elif [ "$OSTYPE" = "darwin" ]; then
    . "$BASHTHINGS_FOLDER"/macOS.zsh
else
    . "$BASHTHINGS_FOLDER"/basic.bash
fi
