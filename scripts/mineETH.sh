#!/usr/bin/env sh

[ "$1" = "-s" ] && amdvbflash -p 0 ~/stockBIOS.rom && reboot
[ "$1" = "-m" ] && amdvbflash -p 0 ~/miningBIOS.rom && reboot
[ "$1" = "-p" ] && docker logs eathtespaghetieu_ethminer_1 && exit

shutDownRGB
amdgpuclocks mining
setGPUfanSpeed 28
docker start eathtespaghetieu_ethminer_1
