#!/usr/bin/env bash

set -e

TARGET=$1
: "${TARGET:=$USER}"

pushd ~/dotfiles > /dev/null || exit

echo "Building home config for ${TARGET}..."
FLAKE_PATH="homeConfigurations.${TARGET}.activationPackage"
# time nix-fast-build --skip-cached --no-nom --flake .#"$FLAKE_PATH"
time nix build .#"$FLAKE_PATH"
# time home-manager build --flake .#"${TARGET}"

popd > /dev/null || exit

