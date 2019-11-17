declare -a TRUELINE_SEGMENTS=(
    'working_dir,special_grey,light_blue,italic'
    'git,special_grey,green'
    'exit_status,white,special_grey'
    'time,white,black'
    #'newline,white,special_grey'
)

declare -A TRUELINE_SYMBOLS=(
    [working_dir_home]='~'
    [clock]='🕒'
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
