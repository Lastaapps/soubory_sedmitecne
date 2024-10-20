{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    alacritty
    alacritty-theme
  ];

  programs.alacritty = {
    enable = true;

    settings = {
      import = [
        # https://github.com/alacritty/alacritty-theme
        "${pkgs.alacritty-theme}/blood_moon.toml"
        # "${pkgs.alacritty-theme}/papercolor_dark.toml"
      ];

      # env.TERM = "xterm-256color";
      window = {
        # decorations = "None";
        opacity = 0.9;
        startup_mode = "Maximized";
        # startup_mode = "Fullscreen";
      };
      font = {
        size = 11.0;
      };
      shell = {
        program = "${pkgs.zsh}/bin/zsh";
        args = [ "-l" ];
      };
      keyboard.bindings = [
        {
          key = "N";
          mods = "Control|Shift";
          action = "SpawnNewInstance";
        }
      ];
      colors = {
        # normal = { green = "0xFFD700"; };
        draw_bold_text_with_bright_colors = true;
      };
    };
  };
}
