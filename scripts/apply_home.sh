#!/usr/bin/env bash

set -e

TARGET=$1
: "${TARGET:=$USER}"

pushd ~/dotfiles > /dev/null

echo "Applying home config for ${TARGET}..."
time home-manager switch --flake .#"${TARGET}"

popd > /dev/null

