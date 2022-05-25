#!/usr/bin/env bash
function genericCompletion() {
    mapfile -t COMPREPLY < <(compgen -W "$1" -- "${COMP_WORDS[COMP_CWORD]}")
}

_aws_switch_completions() {
    commands="$(aws_switch completions)"
    genericCompletion "$commands"
}

complete -F _aws_switch_completions aws_switch
