#!/usr/bin/env bash

# Colors
export C_GREEN='\033[38;5;40m'
export C_RED="\033[38;5;9m"
export F_BOLD="\033[1m"
export C_NO_COLOR='\033[0m' # No Color

function gecho { # Green echo
  echo -e "${C_GREEN}$1${C_NO_COLOR}"
}

function recho { # Red echo
  echo -e "${C_RED}$1${C_NO_COLOR}"
}

function bgecho { # Bold Green echo
  echo -e "${F_BOLD}${C_GREEN}$1${C_NO_COLOR}"
}

function brecho { # Bold Red echo
  echo -e "${F_BOLD}${C_RED}$1${C_NO_COLOR}"
}

export -f gecho
export -f recho
export -f bgecho
export -f brecho
