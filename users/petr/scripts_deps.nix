{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # backup
    xz
    par2cmdline-turbo
  ];
}
