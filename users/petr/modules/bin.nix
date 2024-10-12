{ config, lib, pkgs, ... }:

{
  home.file = {
    "bin" = {
      source = ./bin;
      recursive = true;
    };
  };
}
