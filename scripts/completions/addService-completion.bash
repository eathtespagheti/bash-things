#!/usr/bin/env bash
# shellcheck disable=SC2045

_addService_completions() {
    # No other args
    if [ "${#COMP_WORDS[@]}" -gt "2" ]; then
        return
    fi

    # Check if directory exist
    [ ! -d "$BASHTHINGS_SERVICES" ] && return

    # Generate files list
    files=""
    for item in $(ls "$BASHTHINGS_SERVICES"); do
        [ -f "$BASHTHINGS_SERVICES/$item" ] && files="$files $item"
    done

    mapfile -t COMPREPLY < <(compgen -W "$files" -- "${COMP_WORDS[1]}")
}

complete -F _addService_completions addService
