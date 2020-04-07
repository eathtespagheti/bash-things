#!/usr/bin/env bash

[ -z "$COPYRAW_BASEDIR" ] && COPYRAW_BASEDIR="/run/media/$USER"
complete -W "$(ls "$COPYRAW_BASEDIR")" copyRAW # Run command for autocomplete
