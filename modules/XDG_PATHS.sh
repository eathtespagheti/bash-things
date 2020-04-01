#!/usr/bin/env sh

[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME="$HOME"/.config
[ -z "$XDG_CONFIG_DIRS" ] && export XDG_CONFIG_DIRS="$XDG_CONFIG_HOME" || export XDG_CONFIG_DIRS=:"$XDG_CONFIG_HOME"
[ -z "$XDG_DATA_HOME" ] && export XDG_DATA_HOME="$HOME"/.local/share
[ -z "$XDG_CACHE_HOME" ] && export XDG_CACHE_HOME="$HOME"/.cache

export HISTFILE="$XDG_DATA_HOME"/bash/history
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export NVM_DIR="$XDG_DATA_HOME"/nvm

export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc
export ANDROID_SDK_HOME="$XDG_CONFIG_HOME"/android
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export VIMINIT=":source $XDG_CONFIG_HOME"/vim/vimrc

export LESSKEY="$XDG_CONFIG_HOME"/less/lesskey
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history

export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority