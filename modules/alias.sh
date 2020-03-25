#!/usr/bin/env bash

alias yy="yay -Syu --noconfirm --sudoloop"
alias suspend="systemctl suspend"
alias webhook=$bashthingsScripts/webhook/webhook.sh
alias bash-things-update=$bashthingsScripts/bash-things-update.sh
alias cat="lolcat -l"
alias code="code-insiders"
alias sucode="sudo code-insiders --user-data-dir=\"${HOME}/.vscode-root\""
alias fixtotem="allow_rgb10_configs=false totem"
alias cps="rsync -ah --progress"
alias editBashThings="code-insiders ${bashthingsFolder}"
