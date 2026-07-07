{ pkgs, ... }:
{
  imports = [
    ./backup.nix
    ./java.nix
  ];
  home.packages = with pkgs; [

  ];
}
