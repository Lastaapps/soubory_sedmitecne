{ pkgs, ... }:
{
  home.packages = with pkgs; [
    sshfs
    traceroute
  ];
}
