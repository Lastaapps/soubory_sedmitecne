{ config, lib, pkgs, ... }:

{
  # home.file = {
  #   "${config.xdg.configHome}/alacritty" = {
  #     source = ./alacritty;
  #     recursive = true;
  #   };
  # };

  home.packages = with pkgs; [
    alacritty
    alacritty-theme
  ];

  programs.alacritty = {
    enable = true;

    settings = {
      import = ["${pkgs.alacritty-theme}/usr/share/alacritty/themes/blood_moon.toml"];
      
      # env.TERM = "xterm-256color";
      window = {
        decorations = "None";
	opacity = 0.90;
	# startup_mode = "Fullscreen";
      };
      font = {
        size = 8;
      };
      # selection.save_to_clipboard = true;
      shell = {
        program = "${pkgs.zsh}/bin/zsh";
        args = ["-l"];
      };
      keyboard.bindings = [
        {
          key = "N";
          mods = "Control|Shift";
          action = "SpawnNewInstance";
        }
      ];
    };
  };
}
