#!/usr/bin/env sh

# System management
alias yy="yay -Syu --noconfirm --sudoloop"
alias suspend="systemctl suspend"
alias please="sudo !!"

# Editor selection
if [ "$(command -v /usr/bin/code)" ]; then
    vscode='/usr/bin/code'
elif [ "$(command -v code-insiders)" ]; then
    vscode='code-insiders'
fi
[ -n "$vscode" ] && alias vscode='$vscode'
[ -n "$vscode" ] && alias sucode='$vscode --user-data-dir $XDG_CONFIG_HOME/vscode-root'
[ -n "$EDITOR" ] && alias edit='$EDITOR'
[ -n "$EDITOR_CONSOLE" ] && alias cedit='$EDITOR_CONSOLE'

# Wrappers
alias cps="rsync --archive --human-readable --progress --stats"
alias ccat='highlight --out-format=ansi'
# shellcheck disable=SC2039
[ "$OSTYPE" = "linux-gnu" ] && alias ls='ls --color=auto'

# Bash things specifics
alias editBashThings='$EDITOR $BASHTHINGS_FOLDER'
alias loadVirtualenvwrapper='source loadVirtualenvwrapper'
alias loadNVM="source /usr/share/nvm/init-nvm.sh"
alias load_themes=". load_themes"
