{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Language server
    bash-language-server

    bash
  ];
}
