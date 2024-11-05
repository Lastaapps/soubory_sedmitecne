{ pkgs, pkgs-unstable, ... }:

{
  home.packages = with pkgs; [
    # Language server
    pkgs-unstable.bash-language-server

    bash
  ];
}
