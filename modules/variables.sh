#!/usr/bin/env sh
# shellcheck disable=SC1090

# User info
export NAME="Fabio"
export SURNAME="Sussarellu"
export MATRICOLA="s251489"
export WORKEMAIL="sussarellu.fabio@gmail.com"
export UNIEMAIL="fabio.sussarellu@studenti.polito.it"
# EXIF data
export EXIF_ARTIST="0x013b 0 $NAME $SURNAME"
export EXIF_CONTACT="0x9286 EXIF $WORKEMAIL"
export EXIF_OUTPUT_FOLDER="tagged"

# Bash things folders
export BASHTHINGS_FUNCTIONS="$BASHTHINGS_FOLDER/functions"
export BASHTHINGS_SCRIPTS="$BASHTHINGS_FOLDER/scripts"
export BASHTHINGS_SERVICES="$BASHTHINGS_FOLDER/services"
export BASHTHINGS_MODULES="$BASHTHINGS_FOLDER/modules"
export BASHTHINGS_BIN="$BASHTHINGS_SCRIPTS/bin"
export PROJECTS_FOLDER="$HOME/Projects"

# Coding
# shellcheck disable=SC2039
[ "$OSTYPE" = "linux-gnu" ] && JAVA_HOME=$(readlink -f /usr/bin/javac | sed "s:/bin/javac::")
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

# Qt theme
[ "$(command -v qt5ct)" ] && export QT_QPA_PLATFORMTHEME="qt5ct"

# ls theme
export LS_THEME=snazzy

# Add bash things path
export PATH="$PATH":"$BASHTHINGS_BIN"

# add local user bin to path
export PATH="$PATH":"$HOME"/.local/bin

# Add texlive paths
export PATH="$PATH":/opt/texlive/2020/bin/x86_64-linux
export MANPATH="$MANPATH":/opt/texlive/2020/texmf-dist/doc/man
export INFOPATH="$INFOPATH":/opt/texlive/2020/texmf-dist/doc/info
