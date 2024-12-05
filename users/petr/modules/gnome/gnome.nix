# Also see the system wide config
{ pkgs, pkgs-unstable, ... }:
{
  home.packages = with pkgs; [
    dconf-editor
    dconf2nix # dconf dump / | dconf2nix > dconf.nix
    gnome-tweaks
  ];
  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false; # enables user extensions
        enabled-extensions = (with pkgs.gnomeExtensions; [
          # Packed UUID or manual ones
          # e.g. "blur-my-shell@aunetx"
          appindicator.extensionUuid
          burn-my-windows.extensionUuid
          caffeine.extensionUuid
          gsconnect.extensionUuid
          just-perfection.extensionUuid
          native-window-placement.extensionUuid
          openweather-refined.extensionUuid
          removable-drive-menu.extensionUuid
          # tiling-assistant.extensionUuid
          tiling-shell.extensionUuid
          transparent-window-moving.extensionUuid
          tray-icons-reloaded.extensionUuid
          vitals.extensionUuid
        ]) ++ (with pkgs-unstable.gnomeExtensions; [
        ]);
      };
    };
  };
}
