#!/bin/sh

pushd ~/dotfiles > /dev/null

TARGET=$1
: ${TARGET:=$USER}

home-manager news --flake .#${TARGET}

popd > /dev/null

