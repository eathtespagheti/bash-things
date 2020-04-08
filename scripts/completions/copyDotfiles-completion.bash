#!/usr/bin/env bash

_copyDotfiles_completions() {
    # No other args
    if [ "${#COMP_WORDS[@]}" -gt "2" ]; then
        return
    fi
    local options="--backup --delete-backups --help"
    mapfile -t COMPREPLY < <(compgen -W "$options" -- "${COMP_WORDS[1]}")
}

complete -F _copyDotfiles_completions copyDotfiles
