#!/usr/bin/env bash

# TODO: fix this scripts syntax and checks

bgecho '--- INSTALL DOCKER-MACHINE ---'
gecho 'Installing docker-machine'
$PACKAGE_INSTALL docker-machine $AUTOYES
echo 'OK'

gecho 'Installing docker-machine bash completition'
base=https://raw.githubusercontent.com/docker/machine/v0.15.0
for i in docker-machine-prompt.bash docker-machine-wrapper.bash docker-machine.bash
do
  sudo wget "$base/contrib/completion/bash/${i}" -P /etc/bash_completion.d
done
echo 'OK'
gecho 'Enable docker-machine prompt'
echo > ../functions/docker.sh
echo "# Docker Machine sourcing" > ../functions/docker.sh
echo "source /etc/bash_completion.d/docker-machine-prompt.bash" > ../functions/docker.sh
echo 'OK'
