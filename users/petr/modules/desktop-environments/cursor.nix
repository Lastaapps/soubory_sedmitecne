{ pkgs, ... }:

{
  # in case hyprland breaks the cursor again, run this command:
  # dconf reset /org/gnome/desktop/interface/cursor-theme

  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
    gtk.enable = true;
  };
}
