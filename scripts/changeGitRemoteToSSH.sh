#!/usr/bin/env sh

if [ -z "$1" ]; then
    changeGitRemoteToSSH .
    return 0
else
    url=$(git -C "$1" config --get remote.origin.url)
    echo "$url" | grep -o 'git@' >/dev/null && return 0
    urlPortion=$(echo "$url" | sed 's/https:\/\/.*\.com\///')
    domain=$(echo "$url" | grep -o 'https:\/\/.*\.com\/' | sed 's/https:\/\///;s/\//:/')
    newURL='git@'$domain$urlPortion
    git -C "$1" remote set-url origin "$newURL"
fi
