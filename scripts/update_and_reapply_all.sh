#!/usr/bin/env bash

set -e

pushd ~/dotfiles/scripts > /dev/null || exit

./update_flake.sh
./apply_system.sh
./apply_home.sh

popd > /dev/null || exit

