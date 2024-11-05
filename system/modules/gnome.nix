# Also see the user specific config and GDM config
{ pkgs, pkgs-unstable, ... }:
{
  # Enable the GNOME Desktop Environment.
  services.xserver.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages =
    with pkgs;
    [
    ]
    ++ (with pkgs.gnome; [
      gnome-calendar
      gnome-maps
      gnome-connections
      gnome-characters
      gnome-music
      gnome-contacts
      gnome-text-editor
      gnome-font-viewer
      gnome-photos
      gnome-tour
      gnome-weather

      cheese # webcam tool
      gnome-music
      gnome-terminal
      epiphany # web browser
      geary # email reader
      evince # document viewer
      gnome-characters
      totem # video player
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
    ]);
  environment.systemPackages =
    (with pkgs.gnomeExtensions; [
      appindicator
      burn-my-windows
      caffeine
      gsconnect
      just-perfection
      native-window-placement
      removable-drive-menu
      # tiling-assistant
      transparent-window-moving
      tray-icons-reloaded
      vitals
    ])
    ++ (with pkgs-unstable.gnomeExtensions; [
      openweather-refined
      tiling-shell
    ])
    # Icon theme, apparently some apps need it
    ++ (with pkgs; [ gnome.adwaita-icon-theme ]);

  # ensure gnome-settings-daemon udev rules are enabled
  services.udev.packages = [ pkgs.gnome.gnome-settings-daemon ];

  # KDE Connect
  programs.kdeconnect = {
    enable = true;
    # Gnome, comment for other environments
    package = pkgs.gnomeExtensions.gsconnect;
  };
}
