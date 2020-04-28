#!/usr/bin/env sh

# System management
alias yy="yay -Syu --noconfirm --sudoloop"
alias suspend="systemctl suspend"

# Software I use
[ "$(command -v code)" ] && vscode='code'
[ "$(command -v code-insiders)" ] && vscode='code-insiders'
[ -n "$vscode" ] && alias sucode='$vscode --user-data-dir $XDG_CONFIG_HOME/vscode-root'
[ -n "$EDITOR" ] && alias edit='$EDITOR'
[ -n "$EDITOR_CONSOLE" ] && alias cedit='$EDITOR_CONSOLE'

# Wrappers
alias cps="rsync -ah --progress"
[ "$(command -v lolcat)" ] && alias cat='lolcat -l' && alias ocat='cat'
alias ccat='highlight --out-format=ansi'
alias ls='ls --color=auto'

# Bash things specifics
alias editBashThings='$EDITOR $BASHTHINGS_FOLDER'
alias loadVirtualenvwrapper='source loadVirtualenvwrapper'
alias loadNVM="source /usr/share/nvm/init-nvm.sh"
alias load_themes=". load_themes"
