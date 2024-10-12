{ config, lib, pkgs, ... }:

{
  home.file = {
    "${config.xdg.configHome}/alacritty" = {
      source = ./alacritty;
      recursive = true;
    };
  };
}
