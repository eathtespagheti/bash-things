#!/usr/bin/env bash

gecho 'Downloading bluetooth firmware for BCM43142A0'
sudo wget https://github.com/winterheart/broadcom-bt-firmware/raw/master/brcm/BCM43142A0-0a5c-216c.hcd /lib/firmware/brcm
