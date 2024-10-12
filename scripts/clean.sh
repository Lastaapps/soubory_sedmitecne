#!/bin/sh

pushd ~/dotfiles > /dev/null

# As I uderstand `nix-store --gc` and `nix-collect-garbage` do the same, but idc
sudo nix-store --optimise
sudo nix-store --gc
sudo nix-collect-garbage -d
nix-store --optimise
nix-store --gc
nix-collect-garbage -d

popd > /dev/null
