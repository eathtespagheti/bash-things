#!/usr/bin/env bash

bgecho 'Installing docker-machine bash completition'
base=https://raw.githubusercontent.com/docker/machine/v0.14.0
for i in docker-machine-prompt.bash docker-machine-wrapper.bash docker-machine.bash
do
  sudo wget "$base/contrib/completion/bash/${i}" -P /etc/bash_completion.d
done
echo 'OK'
gecho 'Sourcing docker-machine prompt'
source /etc/bash_completion.d/docker-machine-prompt.bash
echo 'OK'
