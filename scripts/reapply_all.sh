#!/bin/sh

set -e

pushd ~/dotfiles/scripts > /dev/null

./apply_system.sh
./apply_home.sh

popd > /dev/null
