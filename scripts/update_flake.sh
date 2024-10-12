#!/bin/sh

pushd ~/dotfiles > /dev/null

nix flake update

popd > /dev/null

