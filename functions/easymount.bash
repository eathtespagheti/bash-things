#!/usr/bin/env bash

function easymount() {
    local device="/dev/${1}"
    local tmpDirName="tmp"
    local path="/run/media/${USER}/tmp"

    if [ ! -d "${path}" ]; then
        sudo mkdir "$path"
    fi

    sudo mount "$device" "$path" -o umask=000
}

function easyumount() {
    if [ -n "$1" ]; then
        local device="/dev/${1}"
        sudo umount "$device"
        return 0
    fi

    local tmpDirName="tmp"
    local path="/run/media/${USER}/${tmpDirName}"
    sudo umount "$path"
}

export -f easymount >/dev/null
export -f easyumount >/dev/null
