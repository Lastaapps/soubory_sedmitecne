{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Language server
    yaml-language-server
  ];
}
