# This shell can be used to eaither set up the system on a new machine
# or to run system updates in safe environment

{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
  name = "nixosbuildshell";
  nativeBuildInputs = with pkgs; [
    git
    git-crypt
    nixFlakes
  ];

  shellHook = ''
    echo "You can apply this flake to your system with nixos-rebuild switch --flake .#(hostname)"

    echo Commands (from ./scrips):
    echo nupdate - update the flake and apply it
    echo nappply - applys the current version of the flake
    echo nbuild  - builds the flake
    echo nclean  - cleans nix store (should not be needed)

    alias nupdate="~/dotfiles/scripts/update_and_reapply_all.sh"
    alias napply="~/dotfiles/scripts/reapply_all.sh"
    alias nbuild="~/dotfiles/scripts/build.sh"
    alias nclean="~/dotfiles/scripts/clean.sh"

    PATH=${pkgs.writeShellScriptBin "nix" ''
      ${pkgs.nixFlakes}/bin/nix --experimental-features "nix-command flakes" "$@"
    ''}/bin:$PATH
  '';
}
