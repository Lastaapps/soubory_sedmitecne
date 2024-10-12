#!/bin/sh

pushd ~/dotfiles/scripts > /dev/null

./update_flake.sh
./reapply_all.sh

popd > /dev/null

