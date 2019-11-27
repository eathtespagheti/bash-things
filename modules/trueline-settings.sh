#!/usr/bin/env bash

# Change color based on machine name
source $bashthingsFunctions/checkBigChameleon.sh
bgColor="orange"
if checkBigChameleon; then
    bgColor="light_blue"
fi

declare -a TRUELINE_SEGMENTS=(
    'working_dir,special_grey,'$bgColor',italic'
    'git,special_grey,green'
    'exit_status,white,special_grey'
    'time,white,black'
    'docker_machine,white,red,bold'
    #'newline,white,special_grey'
)

declare -A TRUELINE_SYMBOLS=(
    [working_dir_home]='~'
    [clock]='🕒'
    [docker]='' # Docker logo
)

TRUELINE_GIT_MODIFIED_COLOR='black'
TRUELINE_USER_SHOW_IP_SSH=true

_trueline_time_segment() {
    local prompt_time="${TRUELINE_SYMBOLS[clock]} \t"
    if [[ -n "$prompt_time" ]]; then
        local fg_color="$1"
        local bg_color="$2"
        local segment="$(_trueline_separator)"
        segment+="$(_trueline_content "$fg_color" "$bg_color" normal " $prompt_time ")"
        PS1+="$segment"
        _last_color=$bg_color
    fi
}

_trueline_docker_machine_segment() {
    local docker_machine="${TRUELINE_SYMBOLS[docker]} $(__docker_machine_ps1)"
    if [[ -n $(__docker_machine_ps1) ]]; then
        local fg_color="$1"
        local bg_color="$2"
        local font_style="$3"
        local segment="$(_trueline_separator)"
        segment+="$(_trueline_content "$fg_color" "$bg_color" "$font_style" " $docker_machine ")"
        PS1+="$segment"
        _last_color=$bg_color
    fi
}