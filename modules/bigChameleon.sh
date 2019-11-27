#!/usr/bin/env bash

export MAKEFLAGS='-j12'

alias poweroff="webhook pc 0 1 && systemctl poweroff"
alias poweroffSSH="webhook pc 0 1 && sudo systemctl poweroff"
