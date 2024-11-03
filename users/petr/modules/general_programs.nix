# This module is meant for programs that do not need
# any configuration and would just clutter the main modules folder
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    chromium

    ranger
    tmux

    bc
  ];
}
