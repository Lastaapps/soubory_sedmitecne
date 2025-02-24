# This shell can be used to eaither set up the system on a new machine
# or to run system updates in safe environment

{
  pkgs ? import <nixos> { }, # should be more minimal, but fine for Linux
# pkgs ? import <nixpkgs> { }, # should also work on Darwin
}:
pkgs.mkShell {
  name = "nixosbuildshell";
  nativeBuildInputs = with pkgs; [
    git
    git-crypt
    nixVersions.stable

    # Disabled for now as I did not manage the Home manager of the OS switch
    # to use it's results. It also creates output link as `result-` instead of `result`.
    # This possibly also degrades the flake results reusability.
    # Also, it seems that the tool benefits mostly larger projects
    # that can be properly evaluated in parallel.
    # nix-fast-build
  ];

  shellHook = ''
    echo "You can apply this flake to your system with nixos-rebuild switch --flake .#(hostname)"

    echo "--------------------------------------------------------------------------------"
    echo "Commands (from ./scripts):"
    echo "nupdate  - update the flake and apply it"
    echo "nappplys - applys the current version of the flake to the system"
    echo "nappplyh - applys the current version of the flake to home manager"
    echo "nappplyb - applys the current version of the flake to both"
    echo "nbuilds  - builds the flake for system"
    echo "nbuildh  - builds the flake for user"
    echo "nbuildb  - builds the flake for system and user"
    echo "ndry     - dry-builds the flake"
    echo "nclean   - cleans nix store (should not be needed)"
    echo "nnews    - show home-manager's news"
    echo "--------------------------------------------------------------------------------"

    alias nupdate="~/dotfiles/scripts/update_and_reapply_all.sh"

    alias napplys="~/dotfiles/scripts/apply_system.sh"
    alias napplyh="~/dotfiles/scripts/apply_home.sh"
    alias napplyb="~/dotfiles/scripts/apply_system.sh && ~/dotfiles/scripts/apply_home.sh"

    alias nbuilds="~/dotfiles/scripts/build_system.sh"
    alias nbuildh="~/dotfiles/scripts/build_home.sh"
    alias nbuildb="~/dotfiles/scripts/build_system.sh && ~/dotfiles/scripts/build_home.sh"

    alias ndry="~/dotfiles/scripts/dry.sh"
    alias nclean="~/dotfiles/scripts/clean.sh"
    alias nnews="~/dotfiles/scripts/news.sh"

    PATH=${pkgs.writeShellScriptBin "nix" ''
      ${pkgs.nixVersions.stable}/bin/nix --experimental-features "nix-command flakes" "$@"
    ''}/bin:$PATH
  '';
}
