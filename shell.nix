# This shell can be used to eaither set up the system on a new machine
# or to run system updates in safe environment

{
  pkgs ? import <nixpkgs> { },
}:
pkgs.mkShell {
  name = "nixosbuildshell";
  nativeBuildInputs = with pkgs; [
    git
    git-crypt
    nixFlakes
  ];

  shellHook = ''
    echo "You can apply this flake to your system with nixos-rebuild switch --flake .#(hostname)"

    echo "--------------------------------------------------------------------------------"
    echo "Commands (from ./scripts):"
    echo "nupdate - update the flake and apply it"
    echo "nappplys - applys the current version of the flake to the system"
    echo "nappplyh - applys the current version of the flake to home manager"
    echo "nappplyb - applys the current version of the flake to both"
    echo "nbuilds  - builds the flake for system"
    echo "nbuildh  - builds the flake for user"
    echo "nbuildb  - builds the flake for system and user"
    echo "ndry    - dry-builds the flake"
    echo "nclean  - cleans nix store (should not be needed)"
    echo "--------------------------------------------------------------------------------"

    alias nupdate="~/dotfiles/scripts/update_and_reapply_all.sh"
    alias napplys="~/dotfiles/scripts/apply_system.sh"
    alias napplyh="~/dotfiles/scripts/apply_home.sh"
    alias napplyb="~/dotfiles/scripts/reapply_all.sh"
    alias nbuilds="~/dotfiles/scripts/build_system.sh"
    alias nbuildh="~/dotfiles/scripts/build_home.sh"
    alias nbuildb="~/dotfiles/scripts/build.sh"
    alias ndry="~/dotfiles/scripts/dry.sh"
    alias nclean="~/dotfiles/scripts/clean.sh"

    PATH=${pkgs.writeShellScriptBin "nix" ''
      ${pkgs.nixFlakes}/bin/nix --experimental-features "nix-command flakes" "$@"
    ''}/bin:$PATH
  '';
}
