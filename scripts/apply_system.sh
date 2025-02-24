#!/usr/bin/env bash

set -e
 
TARGET=$1
: "${TARGET:=$HOST}"

pushd ~/dotfiles > /dev/null

# sudo is used on echo so I can use userspace time command later without
# measuring the time required to enter the password
sudo echo "Applying system config for ${TARGET}..."
time sudo nixos-rebuild switch --flake .#"${TARGET}"

popd > /dev/null

