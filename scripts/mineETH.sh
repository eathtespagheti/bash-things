#!/usr/bin/env sh

[ "$1" = "-s" ] && sudo amdvbflash -p 0 ~/stockBIOS.rom && reboot
[ "$1" = "-m" ] && sudo amdvbflash -p 0 ~/miningBIOS.rom && reboot

sudo AlterGPUClocks
sudo setGPUfanSpeed 30
sudo systemctl start ethermine
watch sudo systemctl status ethermine.service
