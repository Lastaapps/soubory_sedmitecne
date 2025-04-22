{ pkgs, ... }:

{
  home.packages = with pkgs.elmPackages; [
    elm
    elm-test
    elm-format
    elm-language-server
    elm-analyse
    elm-review

    pkgs.nodejs
  ];
}
