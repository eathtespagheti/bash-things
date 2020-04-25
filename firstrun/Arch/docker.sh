#!/usr/bin/env sh

echo
bgecho '--- DOCKER INSTALL ---'

customInstaller docker

echo
bgecho 'Enabling Docker as a non root user'
gecho 'Adding docker group'
sudo groupadd docker
echo 'OK'
gecho "Adding $USER to the docker group"
sudo usermod -aG docker "$USER"
echo 'OK'

echo
gecho 'Enable Docker at startup'
sudo systemctl enable docker
echo 'OK'

echo
customInstaller docker-compose
