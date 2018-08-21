#!/usr/bin/env bash

# Colors
Green='\033[0;32m'
BGreen='\033[1;32m'
Color_Off='\033[0m' # No Color

# Green echo
function gecho {
  echo -e "${Green}$1${Color_Off}"
}
function bgecho {
  echo -e "${BGreen}$1${Color_Off}"
}
