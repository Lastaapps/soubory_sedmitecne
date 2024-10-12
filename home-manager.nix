{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.petr = import ./home-manager/petr/home.nix;

  # installs packages in a global directory
  home-manager.useUserPackages = true;
  # uses packages defined here, to a specified list per user
  home-manager.useGlobalPkgs = true;
}
