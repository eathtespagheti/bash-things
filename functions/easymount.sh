#!/usr/bin/env bash

function easymount() {
    local device="/dev/${1}"
    local tmpDirName="tmp"
    local path="/run/media/${USER}/${tmpDirName}"

    if [ ! -d "${path}" ]; then
        sudo mkdir $path
    fi

    sudo mount $device $path -o umask=000
}

function easyumount() {
    local device="/dev/${1}"
    sudo umount $device
}

export -f easymount >/dev/null
export -f easyumount >/dev/null
