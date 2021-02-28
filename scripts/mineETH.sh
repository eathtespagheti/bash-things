#!/usr/bin/env sh

[ "$1" = "-s" ] && sudo amdvbflash -p 0 ~/stockBIOS.rom && reboot
[ "$1" = "-m" ] && sudo amdvbflash -p 0 ~/miningBIOS.rom && reboot

amdgpuclocks mining
sudo setGPUfanSpeed 28
sudo systemctl start ethermine
watch sudo systemctl status ethermine.service
