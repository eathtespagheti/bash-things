#!/usr/bin/env bash

waitTime=3
alias poweroff="webhook pc 0 ${waitTime} && systemctl poweroff"
alias poweroffSSH="webhook pc 0 ${waitTime} && sudo systemctl poweroff"
