#!/usr/bin/env bash

function genericCompletion() {
    mapfile -t COMPREPLY < <(compgen -W "$1" -- "${COMP_WORDS[lastWordIndex]}")
}

function listCompletion() {
    genericCompletion "$(gitlabManager | grep ^list | cut -d '[' -f 2 | tr ']' ' ' | tr ':' ' ' | tr ',' ' ')"
}

function cloneCompletion() {
    genericCompletion "$(gitlabManager -l path | sort | tr '\n' ' ')"
}

function actionsCompletion() {
    genericCompletion "$(gitlabManager | grep "^[a-z]" | cut -d ',' -f 1 | sort | tr '\n' ' ')"
}

function shortParametersCompletion() {
    genericCompletion "$(gitlabManager | tr ' ' '\n' | grep "^-[a-z]" | tr ',' ' ' | tr ':' ' ' | sort | tr '\n' ' ')"
}

function longParametersCompletion() {
    genericCompletion "$(gitlabManager | tr ' ' '\n' | grep "^--[a-z]" | tr ':' ' ' | sort | tr '\n' ' ')"
}

_gitlabManager_completions() {
    numberOfWords="${#COMP_WORDS[@]}"

    lastWordIndex="$((numberOfWords - 1))"
    prevParameterIndex="$((numberOfWords - 2))"

    # Switch based on what's user writing
    case "${COMP_WORDS[lastWordIndex]}" in
    --*)
        # Long parameters completion
        longParametersCompletion
        return
        ;;
    -*)
        # Short parameter completion
        shortParametersCompletion
        return
        ;;
    *)
        case "${COMP_WORDS[prevParameterIndex]}" in
        clone)
            cloneCompletion
            return
            ;;
        -c)
            cloneCompletion
            return
            ;;
        list)
            listCompletion
            return
            ;;
        -l)
            listCompletion
            return
            ;;
        -cf)
            _filedir
            return
            ;;
        --config-file)
            _filedir
            return
            ;;
        -pf)
            _filedir
            return
            ;;
        --projects-file)
            _filedir
            return
            ;;
        -gcf)
            _filedir
            return
            ;;
        --clone-folder)
            _filedir
            return
            ;;
        *)
            actionsCompletion
            ;;
        esac
        ;;
    esac
}

complete -F _gitlabManager_completions gitlabManager
