#!/usr/bin/env bash

echo
bgecho '--- DEV-TOOLS INSTALL ---'

gecho 'Installing Firefox, Code and bash-completion'
$PACKAGE_INSTALL firefox-developer-edition code bash-completion $AUTOYES
echo 'OK'
