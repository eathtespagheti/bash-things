#!/usr/bin/env bash
# Inspired from https://gist.github.com/mschuerig/9212290

__snappercomp() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    mapfile -t COMPREPLY < <(compgen -W "$1" -- "$cur")
}

# From http://github.com/jweslley/rails_completion
# @param $1 Name of variable to return result to
# @param $2 Command list
__snappercmd() {
    any_command=$(echo $2 | sed -e 's/[[:space:]]/|/g')
    for ((i = 0; i < ${#COMP_WORDS[@]} - 1; i++)); do
        if [[ ${COMP_WORDS[i]} == @($any_command) ]]; then
            eval $1="${COMP_WORDS[i]}"
        fi
    done
}

__snapper_configs() {
    snapper list-configs | tail -n +3 | awk -F '|' '{ print $1 }'
}

_snapper() {
    local cur prev options command commands
    _init_completion || return

    options="--quiet -q --verbose -v --table-style -t --config -c --no-dbus --version"
    commands="list-configs create-config delete-config get-config set-config \
    list create modify delete mount umount status diff xadiff undochange cleanup"

    settings="ALLOW_GROUPS= ALLOW_USERS= BACKGROUND_COMPARISON= \
    EMPTY_PRE_POST_CLEANUP= EMPTY_PRE_POST_MIN_AGE= \
    NUMBER_CLEANUP= NUMBER_LIMIT= NUMBER_LIMIT_IMPORTANT= NUMBER_MIN_AGE= \
    TIMELINE_CLEANUP= TIMELINE_CREATE= \
    TIMELINE_LIMIT_DAILY= TIMELINE_LIMIT_HOURLY= \
    TIMELINE_LIMIT_MONTHLY= TIMELINE_LIMIT_YEARLY= \
    TIMELINE_MIN_AGE="

    __snappercmd command "$commands"

    if [ -z "$command" ]; then
        case "$prev" in
        -c | --config)
            __snappercomp "$(__snapper_configs)"
            return
            ;;
        esac

        case "$cur" in
        -*) __snappercomp "$options" ;;
        *) __snappercomp "$commands $options" ;;
        esac
        return
    fi

    case "$command" in
    create-config)
        case "$prev" in
        -t | --template) __snappercomp "$(ls /etc/snapper/config-templates)" ;;
        -f | --fstype) __snappercomp "btrfs ext4 lvm" ;;
        *) __snappercomp "-f --fstype -t --template" ;;
        esac
        ;;
    delete-config) ;;
    get-config) ;;
    set-config)
        __snappercomp "$settings"
        ;;
    list)
        case "$prev" in
        -t | --type) __snappercomp "all single pre-post" ;;
        *) __snappercomp "-t --type" ;;
        esac
        ;;
    create)
        case "$prev" in
        -t | --type) __snappercomp "single pre post" ;;
        -c | --cleanup-algorithm) __snappercomp "number timeline empty-pre-post" ;;
        *)
            __snappercomp "-t --type --pre-number \
                                  -p --print-number -d --description \
                                  -c --cleanup-algorithm -u --user-data"
            ;;
        esac
        ;;
    modify)
        case "$prev" in
        -c | --cleanup-algorithm) __snappercomp "number timeline empty-pre-post" ;;
        *) __snappercomp "-d --description -c --cleanup-algorithm \
                                  -u --user-data" ;;
        esac
        ;;
    delete) ;;

    mount) ;;
    umount) ;;
    status)
        case "$prev" in
        -o | --output) _filedir ;;
        *) __snappercomp "-o --output" ;;
        esac
        ;;
    diff)
        _filedir
        ;;
    xadiff)
        _filedir
        ;;
    undochange)
        case "$prev" in
        -i | --input) _filedir ;;
        *) __snappercomp "-i --input" ;;
        esac
        ;;
    cleanup)
        __snappercomp "number timeline pre-post"
        ;;
    *) COMPREPLY=() ;;
    esac
}

complete -o default -F _snapper snapper
