#!/usr/bin/env bash

echo
bgecho '--- MESA INSTALL ---'

gecho "Adding Oibaf's PPA"
sudo add-apt-repository ppa:oibaf/graphics-drivers -y
gecho 'Upgrading Packages'
sudo apt upgrade -y
echo 'OK'

gecho 'Installing PPA-Purge, Vulkan libraries and Mesa Drivers'
sudo apt install ppa-purge libvulkan1 libvulkan-dev vulkan-utils mesa-vdpau-drivers mesa-vulkan-drivers -y
echo 'OK'
