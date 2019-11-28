#!/usr/bin/env bash

alias poweroff="webhook pc 0 1 && systemctl poweroff"
alias poweroffSSH="webhook pc 0 1 && sudo systemctl poweroff"
