#!/usr/bin/env bash

[ -z "$COPYRAW_BASEDIR" ] && export COPYRAW_BASEDIR="/run/media/$USER"
_copyRAW_completions() {
    if [ "${#COMP_WORDS[@]}" != "2" ]; then
        return
    fi

    [ ! -d "$COPYRAW_BASEDIR" ] && return
    mapfile -t COMPREPLY < <(compgen -W "$(ls "$COPYRAW_BASEDIR")" -- "${COMP_WORDS[1]}")
}

complete -F _copyRAW_completions copyRAW
