#!/usr/bin/env bash

export bashthingsFolder=$HOME/.bash_things
export bashthingsFunctions=$bashthingsFolder/functions
export bashthingsScripts=$bashthingsFolder/scripts
export bashthingsModules=$bashthingsFolder/modules
export JAVA_HOME=$(readlink -f /usr/bin/javac | sed "s:/bin/javac::")

# Select the right console editor
if [ $(command -v vim) ]; then
    EDITOR_CONSOLE=vim
elif [ $(command -v nano) ]; then
    EDITOR_CONSOLE=nano
fi
# Select the right GUI editor
if [ $(command -v code-insiders) ]; then
    EDITOR_GUI=code-insiders
elif [ $(command -v code) ]; then
    EDITOR_GUI=code
fi

[ -n "$EDITOR_GUI" ] && EDITOR=$EDITOR_GUI || EDITOR=$EDITOR_CONSOLE
export EDITOR && export EDITOR_CONSOLE && export EDITOR_GUI