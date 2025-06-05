#!/usr/bin/env bash

set -e

pushd ~/dotfiles/scripts > /dev/null || exit

./update_flake.sh
./apply_system.sh
./apply_home.sh

nix_last_diff() {
    local profile_base_path="$1"
    local cmd_prefix=()

    # Add 'sudo' to cmd_prefix if the profile is the system profile.
    [[ "$profile_base_path" == "/nix/var/nix/profiles/system"* ]] && cmd_prefix=(sudo)

    # Get the two most recent generation links
    local gens=$("${cmd_prefix[@]}" ls -t1d "${profile_base_path}"-*-link 2>/dev/null | head -2)
    local old_gen=$(echo "$gens" | sed -n '2p')
    local new_gen=$(echo "$gens" | head -n 1)

    "${cmd_prefix[@]}" nix store diff-closures "$old_gen" "$new_gen"
}

echo "--------------------------------------------------------------------------------"
nix_last_diff /nix/var/nix/profiles/system
echo "--------------------------------------------------------------------------------"
nix_last_diff ~/.local/state/nix/profiles/home-manager
echo "--------------------------------------------------------------------------------"

popd > /dev/null || exit

