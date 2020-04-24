#!/usr/bin/env bash

_copyDotfiles_completions() {
    # No other args
    if [ "${#COMP_WORDS[@]}" -gt "3" ]; then
        return
    fi

    local options="--backup --delete-backups --help --replace-backups"

    # No other args
    if [ "${#COMP_WORDS[@]}" -gt "2" ]; then
        options="${options/${COMP_WORDS[2]}/}"
        mapfile -t COMPREPLY < <(compgen -W "$options" -- "${COMP_WORDS[2]}")
    fi

    mapfile -t COMPREPLY < <(compgen -W "$options" -- "${COMP_WORDS[1]}")
}

complete -F _copyDotfiles_completions copyDotfiles
