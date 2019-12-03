#!/usr/bin/env bash

function installer() { # Install a package, input args are "command to install" "package name" "commando to autoconfirm"
    bgecho '--- Installing '$2' ---'
    $1 $2 $3
    echo 'OK'
}

export -f installer >/dev/null
