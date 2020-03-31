#!/usr/bin/env bash

# Colors
C_GREEN='\033[38;5;40m'
C_RED="\033[38;5;9m"
F_BOLD="\033[1m"
C_NO_COLOR='\033[0m' # No Color

gecho() { # Green echo
  # shellcheck disable=SC2059
  printf "${C_GREEN}$1${C_NO_COLOR}\n"
}

recho() { # Red echo
  # shellcheck disable=SC2059
  printf "${C_RED}$1${C_NO_COLOR}\n"
}

bgecho() { # Bold Green echo
  # shellcheck disable=SC2059
  printf "${F_BOLD}${C_GREEN}$1${C_NO_COLOR}\n"
}

brecho() { # Bold Red echo
  # shellcheck disable=SC2059
  printf "${F_BOLD}${C_RED}$1${C_NO_COLOR}\n"
}

export -f gecho >/dev/null
export -f recho >/dev/null
export -f bgecho >/dev/null
export -f brecho >/dev/null
