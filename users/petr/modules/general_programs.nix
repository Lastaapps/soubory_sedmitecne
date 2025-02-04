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
    obs-studio
    saber
    texliveFull
    postman
    vlc

    apktool
    ranger
    tmux

    bc
    ffmpeg-full
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
