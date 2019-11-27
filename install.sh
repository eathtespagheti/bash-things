#!/usr/bin/env bash

echo "Clone bash things"
git clone https://gitlab.com/Fabi0Z/bash-things.git .bash_things
echo
echo "Clone trueline"
git clone https://github.com/petobens/trueline.git .bash_things/trueline
echo
echo "Clone webhook"
git clone https://gitlab.com/Fabi0Z/webhook.git .bash_things/script/webhook
echo
echo "Execute firstrun script"
./.bash_things/firstrun.sh