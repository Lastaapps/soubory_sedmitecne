# Also see the user specific config and GDM config
{ pkgs, pkgs-unstable, ... }:
{
  # Enable the GNOME Desktop Environment.
  services.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = with pkgs; [
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

    atomix # puzzle game
    cheese # webcam tool
    decibels # music player
    epiphany # web browser
    geary # email reader
    gnome-characters
    gnome-music
    gnome-terminal
    hitori # sudoku game
    iagno # go game
    papers
    showtime
    tali # poker game
  ];
  environment.systemPackages =
    (with pkgs.gnomeExtensions; [
      appindicator
      auto-move-windows
      burn-my-windows
      caffeine
      gsconnect
      just-perfection
      native-window-placement
      openweather-refined
      removable-drive-menu
      # tiling-assistant
      tiling-shell
      transparent-window-moving
      tray-icons-reloaded
      vitals
    ])
    ++ (with pkgs-unstable.gnomeExtensions; [
    ])
    # Icon theme, apparently some apps need it
    ++ (with pkgs; [ adwaita-icon-theme ]);

  # ensure gnome-settings-daemon udev rules are enabled
  services.udev.packages = [ pkgs.gnome-settings-daemon ];

  # KDE Connect
  programs.kdeconnect = {
    enable = true;
    # Gnome, comment for other environments
    package = pkgs.gnomeExtensions.gsconnect;
  };
}
