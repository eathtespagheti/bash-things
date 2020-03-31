#!/usr/bin/env bash

alias yy="yay -Syu --noconfirm --sudoloop"
alias suspend="systemctl suspend"
alias webhook=$bashthingsScripts/webhook/webhook.sh
alias bash-things-update=$bashthingsScripts/bash-things-update.sh
[ $(command -v lolcat) ] && alias cat="lolcat -l"
[ -n "$EDITOR" ] && alias edit=$EDITOR && alias suedit="sudo ${EDITOR}"
[ -n "$EDITOR_CONSOLE" ] && alias editc=$EDITOR_CONSOLE && alias sueditc=$EDITOR_CONSOLE
# alias fixtotem="allow_rgb10_configs=false totem"
alias cps="rsync -ah --progress"
alias editBashThings="${EDITOR} ${bashthingsFolder}"
