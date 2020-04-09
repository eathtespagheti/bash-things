#!/usr/bin/env sh
# shellcheck disable=SC1090

export BASHTHINGS_FUNCTIONS=$BASHTHINGS_FOLDER/functions
export BASHTHINGS_SCRIPTS=$BASHTHINGS_FOLDER/scripts
export BASHTHINGS_MODULES=$BASHTHINGS_FOLDER/modules
export BASHTHINGS_BIN=$BASHTHINGS_SCRIPTS/bin
JAVA_HOME=$(readlink -f /usr/bin/javac | sed "s:/bin/javac::")
[ -n "$JAVA_HOME" ] && export JAVA_HOME

# Select the right console editor
if [ "$(command -v vim)" ]; then
    EDITOR_CONSOLE=vim
elif [ "$(command -v nano)" ]; then
    EDITOR_CONSOLE=nano
fi
# Select the right GUI editor
if [ "$(command -v code-insiders)" ]; then
    EDITOR_GUI=code-insiders
elif [ "$(command -v code)" ]; then
    EDITOR_GUI=code
fi

[ -n "$EDITOR_GUI" ] && EDITOR=$EDITOR_GUI || EDITOR=$EDITOR_CONSOLE
export EDITOR && export EDITOR_CONSOLE && export EDITOR_GUI

# ls theme
export LS_THEME=snazzy

# EXIF data
export EXIF_ARTIST="Fabio Sussarellu"

# Add bash things path
export PATH="$PATH":"$BASHTHINGS_BIN"

# add local user bin to path
export PATH="$PATH":"$HOME"/.local/bin
