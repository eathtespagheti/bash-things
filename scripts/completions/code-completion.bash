#!/usr/bin/env bash

_complete_specific_path() {
    # declare variables
    local _item _COMPREPLY _old_pwd

    # if we already are in the completed directory, skip this part
    if [ "${PWD}" != "$1" ]; then
        _old_pwd="${PWD}"
        # magic here: go the specific directory!
        pushd "$1" &>/dev/null || return

        # init completion and run _filedir inside specific directory
        _init_completion -s || return
        _filedir

        # iterate on original replies
        for _item in "${COMPREPLY[@]}"; do
            # this check seems complicated, but it handles the case
            # where you have files/dirs of the same name
            # in the current directory and in the completed one:
            # we want only one "/" appended
            if [ -d "${_item}" ] && [[ "${_item}" != */ ]] && [ ! -d "${_old_pwd}/${_item}" ]; then
                # append a slash if directory
                _COMPREPLY+=("${_item}/")
            else
                _COMPREPLY+=("${_item}")
            fi
        done

        # popd as early as possible
        popd &>/dev/null || exit

        # if only one reply and it is a directory, don't append a space
        # (don't know why we must check for length == 2 though)
        if [ ${#_COMPREPLY[@]} -eq 2 ]; then
            if [[ "${_COMPREPLY[0]}" == */ ]]; then
                compopt -o nospace
            fi
        fi

        # set the values in the right COMPREPLY variable
        COMPREPLY=("${_COMPREPLY[@]}")

        # clean up
        unset _COMPREPLY
        unset _item
    else
        # we already are in the completed directory, easy
        _init_completion -s || return
        _filedir
    fi
}

# If default dir doesn't exist
[ -z "$PROJECTS_FOLDER" ] && export PROJECTS_FOLDER="$HOME/Projects"

_code_completions() {
    _complete_specific_path "$PROJECTS_FOLDER"
}

complete -o nospace -F _code_completions code
