#!/usr/bin/env bash

# If default dir doesn't exist
[ -z "$COPYRAW_BASEDIR" ] && export COPYRAW_BASEDIR="/run/media/$USER"

_copyRAW_completions() {
    # No other args
    if [ "${#COMP_WORDS[@]}" -gt "2" ]; then
        return
    fi

    # Check if directory exist
    [ ! -d "$COPYRAW_BASEDIR" ] && return
    mapfile -t COMPREPLY < <(compgen -W "$(ls "$COPYRAW_BASEDIR")" -- "${COMP_WORDS[1]}")
}

complete -F _copyRAW_completions copyRAW
