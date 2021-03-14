#!/usr/bin/env sh

[ "$1" = "-s" ] && amdvbflash -p 0 ~/stockBIOS.rom && reboot
[ "$1" = "-m" ] && amdvbflash -p 0 ~/miningBIOS.rom && reboot
[ "$1" = "-p" ] && watch systemctl status ethermine.service && exit

shutDownRGB
amdgpuclocks mining
setGPUfanSpeed 28
systemctl start ethermine