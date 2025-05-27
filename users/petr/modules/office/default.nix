{ pkgs, ... }:
{
  imports = [
    ./libre-office.nix
  ];
  home.packages = with pkgs; [
    kdePackages.okular
  ];
}
