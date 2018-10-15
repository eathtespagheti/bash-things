#!/usr/bin/env bash

gecho 'Installing WiFi Drivers'
sudo apt --reinstall install bcmwl-kernel-source -y

gecho 'Downloading bluetooth firmware for BCM43142A0'
wget https://github.com/winterheart/broadcom-bt-firmware/raw/master/brcm/BCM43142A0-0a5c-216c.hcd
sudo mv BCM43142A0-0a5c-216c.hcd /lib/firmware/brcm/BCM43142A0-0a5c-216c.hcd
