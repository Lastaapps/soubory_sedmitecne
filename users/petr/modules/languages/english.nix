{ pkgs, pkgs-unstable, ... }:

{
  home.packages = with pkgs; [
    # Language server
    pkgs-unstable.ltex-ls-plus

    languagetool
    fasttext
  ];
}
