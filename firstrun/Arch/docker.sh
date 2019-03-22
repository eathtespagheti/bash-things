#!/usr/bin/env bash

echo
bgecho '--- DOCKER INSTALL ---'

gecho 'Installing Docker CE'
$PACKAGE_INSTALL docker $AUTOYES

echo
bgecho 'Enabling Docker as a non root user'
gecho 'Adding docker group'
sudo groupadd docker
echo 'OK'
gecho "Adding ${USER} to the docker group"
sudo usermod -aG docker $USER
echo 'OK'

echo
gecho 'Enable Docker at startup'
sudo systemctl enable docker
echo 'OK'

echo
gecho 'Installing docker-compose'
$PACKAGE_INSTALL docker-compose $AUTOYES
