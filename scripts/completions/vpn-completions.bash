#!/usr/bin/env bash
# Copyright (C) 2021 Fabio Sussarellu
#
# This file is part of bash_things.
#
# bash_things is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# bash_things is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with bash_things.  If not, see <http://www.gnu.org/licenses/>.

function genericCompletion() {
    mapfile -t COMPREPLY < <(compgen -W "$1" -- "${COMP_WORDS[COMP_CWORD]}")
}

_vpn_completions() {
    commands="$(vpn | head -n 1 | cut -d ' ' -f 3 | tr '[' '|' | tr ']' '|' | cut -d '|' -f 2,3,4 | tr '|' ' ')"
    genericCompletion "$commands"
}

complete -F _vpn_completions vpn
