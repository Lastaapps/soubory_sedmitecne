# This module is meant for programs that do not need
# any configuration and would just clutter the main modules folder
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    chromium
    digikam
    inkscape
    gparted
    obs-studio
    okular
    postman
    saber
    texliveFull
    vlc
    zettlr

    apktool
    ranger
    tmux

    bc
    ffmpeg-full
    ncdu
    sshfs
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
