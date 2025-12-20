{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Language server
    tinymist
    typstyle

    typst
  ];
}
