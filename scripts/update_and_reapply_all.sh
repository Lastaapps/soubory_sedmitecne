#!/usr/bin/env bash

set -e

pushd ~/dotfiles/scripts > /dev/null || exit

sudo echo "Starting..."
./update_flake.sh
./apply_system.sh
./apply_home.sh
./latest_changes.sh

popd > /dev/null || exit

