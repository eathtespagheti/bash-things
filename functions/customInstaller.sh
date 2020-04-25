#!/usr/bin/env sh

packagesList=""
# If package isn't installed
if [ -n "$PACKAGE_CHECK" ]; then
    for package in "$@"; do
        $PACKAGE_CHECK "$package" || packagesList="$packagesList $package"
    done
else
    for package in "$@"; do
        packagesList="$packagesList $package"
    done
fi

if [ -n "$packagesList" ]; then
    bgecho "--- Installing $packagesList ---"
    bashthingsLogger "--- Installing $packagesList ---"
    # shellcheck disable=SC2086
    $PACKAGE_INSTALL $packagesList $AUTOYES
else
    bgecho "All packages are already installed"
fi
echo
