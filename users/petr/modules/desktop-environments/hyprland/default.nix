{ pkgs, config, ... }:
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
    ./waybar.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    # set the Hyprland and XDPH packages to null to use the ones from the NixOS module
    package = null;
    portalPackage = null;
  };

  home.packages = with pkgs; [
    # notifications deamon
    dunst

    # streaming, music, idk
    pipewire
    wireplumber

    #  QT support
    hyprland-qt-support
    # qt5.full
    qt6.full

    # D-Bus file picker (probably other can be chosen later)
    xdg-desktop-portal-gtk

    # Menu
    wofi
  ];

  # wayland.windowManager.hyprland.extraConfig = configText;
  wayland.windowManager.hyprland.extraConfig = ''
    source = ${configPath}
  '';
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    bind =
      [
        "$mod, F, exec, firefox"
        ", Print, exec, grimblast copy area"

        "$mod, Return, exec, alacritty"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (
          builtins.genList (
            i:
            let
              ws = i + 1;
            in
            [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          ) 9
        )
      );
  };

  # wayland.windowManager.hyprland.plugins = [
  #   inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprbars
  #   "/absolute/path/to/plugin.so"
  # ];

  # Permissions dialog
  services.hyprpolkitagent.enable = true;
}
