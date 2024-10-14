{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Language server
    ltex-ls
  ];
}
