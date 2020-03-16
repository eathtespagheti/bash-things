#!/usr/bin/env bash

export bashthingsFolder=$HOME/.bash_things
export bashthingsFunctions=$bashthingsFolder/functions
export bashthingsScripts=$bashthingsFolder/scripts
export bashthingsModules=$bashthingsFolder/modules
export JAVA_HOME=$(readlink -f /usr/bin/javac | sed "s:/bin/javac::")
