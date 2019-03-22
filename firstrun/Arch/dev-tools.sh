#!/usr/bin/env bash

echo
bgecho '--- DEV-TOOLS INSTALL ---'

gecho 'Installing Vivaldi Browser, Atom and bash-completion'
$PACKAGE_INSTALL vivaldi atom bash-completion $AUTOYES
echo 'OK'
