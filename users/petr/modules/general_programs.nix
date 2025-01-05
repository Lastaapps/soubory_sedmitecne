# This module is meant for programs that do not need
# any configuration and would just clutter the main modules folder
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    chromium
    zettlr
    okular
    digikam
    inkscape
    saber
    texliveFull
    postman
    vlc

    apktool
    ranger
    tmux

    bc
    ncdu
    traceroute

    # Fun
    aalib # aafire
    asciiquarium-transparent
    cmatrix
    cowsay
    fortune
    nyancat
    sl
  ];
}
