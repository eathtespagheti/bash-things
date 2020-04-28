#!/usr/bin/env sh
# shellcheck disable=SC1090

export BASHTHINGS_FUNCTIONS="$BASHTHINGS_FOLDER/functions"
export BASHTHINGS_SCRIPTS="$BASHTHINGS_FOLDER/scripts"
export BASHTHINGS_MODULES="$BASHTHINGS_FOLDER/modules"
export BASHTHINGS_BIN="$BASHTHINGS_SCRIPTS/bin"
export PROJECTS_FOLDER="$HOME/Projects"
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
elif [ "$(command -v gedit)" ]; then
    EDITOR_GUI=gedit
else
    EDITOR_GUI="$EDITOR_CONSOLE"
fi

# If I'm running a GUI session
if [ -n "$DISPLAY" ]; then
    EDITOR=$EDITOR_GUI
else
    EDITOR=$EDITOR_CONSOLE
fi
export EDITOR && export EDITOR_CONSOLE && export EDITOR_GUI

# ls theme
export LS_THEME=snazzy

# EXIF data
export EXIF_ARTIST="0x013b 0 Fabio Sussarellu"
export EXIF_CONTACT="0x9286 EXIF sussarellu.fabio@gmail.com"
export EXIF_OUTPUT_FOLDER="tagged"

# Add bash things path
export PATH="$PATH":"$BASHTHINGS_BIN"

# add local user bin to path
export PATH="$PATH":"$HOME"/.local/bin
