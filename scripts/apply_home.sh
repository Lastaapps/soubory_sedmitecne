#!/bin/sh

pushd ~/dotfiles > /dev/null

TARGET=$1
: ${TARGET:=$USER}

home-manager switch --flake .#${TARGET}

popd > /dev/null

