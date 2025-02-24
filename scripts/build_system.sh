#!/usr/bin/env bash

set -e

TARGET=$1
: "${TARGET:=$(hostname)}"

pushd ~/dotfiles > /dev/null || exit

echo "Building system config for ${TARGET}..."
FLAKE_PATH="nixosConfigurations.${TARGET}.config.system.build.toplevel"
# time nix-fast-build --skip-cached --no-nom --flake .#"$FLAKE_PATH"
time nix build .#"$FLAKE_PATH"
# time nixos-rebuild build --flake .#"${TARGET}"

popd > /dev/null || exit

