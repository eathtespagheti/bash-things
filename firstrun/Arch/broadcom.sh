#!/usr/bin/env bash

# TODO: fix this scripts syntax and checks

gecho 'Installing linux-headers'
$PACKAGE_INSTALL linux-headers dkms $AUTOYES

gecho 'Installing WiFi Drivers'
$PACKAGE_INSTALL broadcom-wl-dkms $AUTOYES
