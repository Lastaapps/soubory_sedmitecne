{ pkgs, ... }:

{
  home.packages = with pkgs; [
    libreoffice-qt
    hunspell
    hunspellDicts.en-us-large
    hunspellDicts.cs-cz
    hunspellDicts.de-de
  ];
}
