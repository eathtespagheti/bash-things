#!/usr/bin/env sh

[ "$(command -v fortune)" ] && [ "$(command -v cowsay)" ] && fortune | cowsay
