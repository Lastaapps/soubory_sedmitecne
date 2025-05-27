{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Language server
    tinymist
    typst-fmt

    typst
  ];
}
