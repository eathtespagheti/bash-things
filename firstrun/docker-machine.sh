#!/usr/bin/env bash

bgecho '--- INSTALL DOCKER-MACHINE ---'
gecho 'Downloading docker machine'
base=https://github.com/docker/machine/releases/download/v0.14.0
curl -L $base/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine
echo 'OK'
gecho 'Installing docker-machine'
sudo install /tmp/docker-machine /usr/local/bin/docker-machine
echo 'OK'
gecho 'Installing docker-machine bash completition'
base=https://raw.githubusercontent.com/docker/machine/v0.14.0
for i in docker-machine-prompt.bash docker-machine-wrapper.bash docker-machine.bash
do
  sudo wget "$base/contrib/completion/bash/${i}" -P /etc/bash_completion.d
done
echo 'OK'
gecho 'Sourcing docker-machine prompt'
source /etc/bash_completion.d/docker-machine-prompt.bash
echo 'OK'
