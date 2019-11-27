#!/usr/bin/env bash

export bashthingsFolder=$HOME/.bash_things
export bashthingsFunctions=$bashthingsFolder/functions
export bashthingsScripts=$bashthingsFolder/scripts
export bashthingsModules=$bashthingsFolder/modules

# macOS check
source $bashthingsFunctions/checkOS.sh
if [ "$machine" = "Mac" ]; then
    export HOME="/Users/${USER}"
fi
