#!/usr/bin/env sh

bgecho 'Enable bash_things in .bashrc'
{
    echo
    echo "# Customization"
    echo "source ${BASHTHINGS_FOLDER}/loader.sh"
} >>"$HOME/.bashrc"
