{ config, pkgs, ... }:

let
  dir = "${config.home.homeDirectory}/dotfiles/users/petr/modules/desktop-environments/waybar/";
  configPath = dir + "config.jsonc";
  stylesPath = dir + "style.css";
  mediaPlayerPath = dir + "media_player.py";
  powerMenuPath = dir + "power_menu.xml";
in
{
  home.packages = with pkgs; [
    python3Packages.pygobject3
  ];
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
    };

    # style = ''
    #   * {
    #     border: none;
    #     border-radius: 0;
    #     font-family: Source Code Pro;
    #   }
    #   window#waybar {
    #     background: #16191C;
    #     color: #AAB2BF;
    #   }
    #   #workspaces button {
    #     padding: 0 5px;
    #   }
    # '';
  };

  xdg.configFile."waybar/config.jsonc".source = config.lib.file.mkOutOfStoreSymlink configPath;
  xdg.configFile."waybar/style.css".source = config.lib.file.mkOutOfStoreSymlink stylesPath;
  xdg.configFile."waybar/music_player.py".source =
    config.lib.file.mkOutOfStoreSymlink mediaPlayerPath;
  xdg.configFile."waybar/power_menu.xml".source = config.lib.file.mkOutOfStoreSymlink powerMenuPath;
}
