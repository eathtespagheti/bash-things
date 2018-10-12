#!/usr/bin/env bash

gecho 'Installing exfat drivers'
sudo apt install exfat-fuse exfat-utils -y
echo 'OK'
