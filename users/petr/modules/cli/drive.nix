{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ncdu
    btrfs-progs
  ];
}
