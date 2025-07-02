{
  inputs,
  pkgs,
  config,
  ...
}:
let
  configText = builtins.readFile ./hyprconfig.conf;
  configPath = "${config.home.homeDirectory}/dotfiles/users/petr/modules/desktop-environments/hyprland/hyprconfig.conf";
in
{
  imports = [
    ./hyprpaper.nix
    ./hypridle.nix
    ./hyprlock.nix
    # TODO Fails for some reason...
    # ./hyprsunset.nix
    ./dunst.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    # set the Hyprland and XDPH packages to null to use the ones from the NixOS module
    package = null;
    portalPackage = null;

    plugins = with inputs.hyprland-plugins.packages.${pkgs.system}; [
      # https://github.com/hyprwm/hyprland-plugins/tree/main
      hyprbars
      hyprexpo
      hyprscrolling
      hyprwinwrap # TODO apply htop or something to the background
    ];
  };

  home.packages = with pkgs; [
    # control utils
    brightnessctl
    playerctl
    nwg-displays
    nwg-bar

    #  QT support
    hyprland-qt-support
    # qt5.full
    qt6.full

    # D-Bus file picker (probably other can be chosen later)
    xdg-desktop-portal-gtk

    # Menu
    wofi

    # Other utils
    libsForQt5.kdeconnect-kde
  ];

  # wayland.windowManager.hyprland.extraConfig = configText;
  wayland.windowManager.hyprland.extraConfig = ''
    source = ${configPath}
  '';
  wayland.windowManager.hyprland.settings = { };

  # wayland.windowManager.hyprland.plugins = [
  #   inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprbars
  #   "/absolute/path/to/plugin.so"
  # ];

  # Permissions dialog
  services.hyprpolkitagent.enable = true;
}
