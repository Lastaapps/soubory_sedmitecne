#!/bin/sh

TARGET=$1
: ${TARGET:=$USER}

pushd ~/dotfiles > /dev/null

home-manager build --flake .#${TARGET}

popd > /dev/null

