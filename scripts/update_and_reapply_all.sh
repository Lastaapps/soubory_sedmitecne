#!/usr/bin/env bash

set -e

pushd ~/dotfiles/scripts > /dev/null || exit

./update_flake.sh
./apply_system.sh
./apply_home.sh

echo "--------------------------------------------------------------------------------"
nix profile diff-closures --profile /nix/var/nix/profiles/system
echo "--------------------------------------------------------------------------------"
nix profile diff-closures --profile ~/.local/state/nix/profiles/home-manager
echo "--------------------------------------------------------------------------------"

popd > /dev/null || exit

