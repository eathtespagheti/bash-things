#!/usr/bin/env bash
# shellcheck disable=SC2045

_linkToBin_completions() {
    # No other args
    if [ "${#COMP_WORDS[@]}" -gt "2" ]; then
        return
    fi

    # Check if directory exist
    [ ! -d "$BASHTHINGS_SCRIPTS" ] && return

    # Generate files list
    files=""
    for item in $(ls "$BASHTHINGS_SCRIPTS"); do
        [ -f "$BASHTHINGS_SCRIPTS/$item" ] && files="$files $item"
    done

    mapfile -t COMPREPLY < <(compgen -W "$files" -- "${COMP_WORDS[1]}")
}

complete -F _linkToBin_completions linkToBin
