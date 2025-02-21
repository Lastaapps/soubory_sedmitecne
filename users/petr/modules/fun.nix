{ pkgs, ... }:
{
  home.packages = with pkgs; [
    aalib # aafire
    asciiquarium-transparent
    cmatrix
    cowsay
    cowsay
    fastfetch
    fortune
    nyancat
    sl
  ];
}
