{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cifs-utils
    sshfs
    traceroute
  ];
}
