#!/usr/bin/env sh

# System management
alias yy="yay -Syu --noconfirm --sudoloop"
alias suspend="systemctl suspend"

# Software I use
[ "$(command -v code)" ] && code='code'
[ "$(command -v code-insiders)" ] && code='code-insiders'
[ -n "$code" ] && alias sucode='$code --user-data-dir $XDG_CONFIG_HOME/vscode-root'
[ -n "$EDITOR" ] && alias edit='$EDITOR' && alias suedit='sudo $EDITOR'
[ -n "$EDITOR_CONSOLE" ] && alias editc='$EDITOR_CONSOLE' && alias sueditc='sudo $EDITOR_CONSOLE'

# Wrappers
alias webhook='$BASHTHINGS_SCRIPTS/webhook/webhook.sh'
alias cps="rsync -ah --progress"
[ "$(command -v lolcat)" ] && alias cat='lolcat -l' && alias ocat='cat'
alias ccat='highlight --out-format=ansi'

# Bash things specifics
alias bash-things-update='$BASHTHINGS_SCRIPTS/bash-things-update.bash'
alias editBashThings='$EDITOR $BASHTHINGS_FOLDER'
alias loadVirtualenvwrapper='source $BASHTHINGS_MODULES/virtualenvwrapper.sh'
alias loadNVM="source /usr/share/nvm/init-nvm.sh"
