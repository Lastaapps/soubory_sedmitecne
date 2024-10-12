#!/bin/sh

pushd ~/dotfiles > /dev/null

sudo nixos-rebuild switch --flake .#${1}

popd > /dev/null

