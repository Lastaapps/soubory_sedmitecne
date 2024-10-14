#!/bin/sh

pushd ~/dotfiles > /dev/null

nixos-rebuild build --flake .#${1}

popd > /dev/null

