#!/usr/bin/env bash

function customInstaller() { # Install a package, input args are "command to install" "package name" "commando to autoconfirm"
    bgecho '--- Installing '$2' ---'
    $1 $2 $3
    echo 'OK'
}

export -f customInstaller >/dev/null
