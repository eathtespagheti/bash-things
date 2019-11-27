#!/usr/bin/env bash

# Colors
export Green='\033[0;32m'
export BGreen='\033[1;32m'
export BRed='\033[1;32m'
export Color_Off='\033[0m' # No Color

function gecho { # Green echo
  echo -e "${Green}$1${Color_Off}"
}

function bgecho { # Bold Green echo
  echo -e "${BGreen}$1${Color_Off}"
}
function brecho { # Bold Red echo
  echo -e "${BRed}$1${Color_Off}"
}

bgecho '--- EXPORTING ECHO FUNCTIONS ---'
export -f gecho
export -f bgecho
export -f brecho
