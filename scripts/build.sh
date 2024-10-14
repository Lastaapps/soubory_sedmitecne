#!/bin/sh

TARGET=$1
: ${TARGET:=$USER}

pushd ~/dotfiles > /dev/null

nixos-rebuild build --flake .#${1}
home-manager build --flake .#${TARGET}

popd > /dev/null

