#!/usr/bin/env bash

echo
bgecho '--- MESA INSTALL ---'

gecho 'Vulkan libraries, Mesa Drivers, DXVK and Lutris'
$PACKAGE_INSTALL vulkan-radeon lib32-vulkan-radeon lib32-vulkan-icd-loader mesa $AUTOYES
echo 'OK'
