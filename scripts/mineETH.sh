#!/usr/bin/env sh

sudo AlterGPUClocks
sudo setGPUfanSpeed 35
sudo systemctl start ethermine
watch sudo systemctl status ethermine.service