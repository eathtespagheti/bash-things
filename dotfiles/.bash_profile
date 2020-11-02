#!/usr/bin/env sh
# shellcheck disable=SC1090

SESSION_TYPE=local
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ] || [ -n "$SSH_CONNECTION" ]; then
    SESSION_TYPE=remote/ssh
else
    case $(ps -o comm= -p $PPID) in
    sshd | */sshd) SESSION_TYPE=remote/ssh ;;
    esac
fi

if [ -f ~/.bashrc ] && [ "$SESSION_TYPE" = "remote/ssh" ]; then
    . ~/.bashrc
fi

export SESSION_TYPE
