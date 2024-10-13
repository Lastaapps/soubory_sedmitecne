#!/bin/sh

pushd ~/dotfiles > /dev/null

nixos-rebuild dry-build --flake .#${1}

popd > /dev/null

