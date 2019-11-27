#!/usr/bin/env bash

source ".bash_things/functions/checkOS.sh"

if [ "$machine" = "Linux" ]; then
    ./.bash_things/firstrun/firstrun-arch.sh
elif [ "$machine" = "Mac" ]; then
    ./.bash_things/firstrun/firstrun-macos.sh
else
    echo "Unable to determine Operating System"
    exit 1
fi
