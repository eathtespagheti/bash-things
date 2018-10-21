#!/usr/bin/env bash
RECENTKERNEL='418'

gecho 'Install Linux Kernel $(RECENTKERNEL)'
sudo mhwd-kernel -i linux$RECENTKERNEL

gecho 'Installing linux-headers'
$PACKAGE_INSTALL linux$RECENTKERNEL-headers $AUTOYES

gecho 'Installing WiFi Drivers'
$PACKAGE_INSTALL broadcom-wl-dkms $AUTOYES
