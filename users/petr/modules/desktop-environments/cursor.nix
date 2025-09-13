{ pkgs, ... }:

{
  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24; # You can adjust this size
  };
}
