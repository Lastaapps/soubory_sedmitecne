#!/bin/sh

pushd ~/dotfiles > /dev/null

# As I uderstand `nix-store --gc` and `nix-collect-garbage` do the same, but idc
sudo nix-collect-garbage --delete-older-than 30d
sudo nix-store --optimise
nix-collect-garbage --delete-older-than 30d
nix-store --optimise

popd > /dev/null
