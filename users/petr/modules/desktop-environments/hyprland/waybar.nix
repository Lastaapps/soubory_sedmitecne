{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
    };

    settings = {
      mainBar = {
        # To use the workspaces module, replace all the occurrences of
        # sway/workspaces with hyprland/workspaces. Addionally replace all
        # occurences of sway/mode with hyprland/submap

        layer = "top";
        position = "top";
        height = 30;
        output = [
          "eDP-1"
          # "HDMI-A-1"
        ];
        modules-left = [
          "sway/workspaces"
          "sway/mode"
          "hyprland/workspaces"
          "hyprland/submap"
          "wlr/taskbar"
        ];
        modules-center = [
          "sway/window"
          # "custom/hello-from-waybar"
        ];
        modules-right = [
          "mpd"
          "custom/mymodule#with-css-id"
          "temperature"
        ];

        "hyrpland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
        };
        # "custom/hello-from-waybar" = {
        #   format = "hello {}";
        #   max-length = 40;
        #   interval = "once";
        #   exec = pkgs.writeShellScript "hello-from-waybar" ''
        #     echo "from within waybar"
        #   '';
        # };
      };
    };
    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: Source Code Pro;
      }
      window#waybar {
        background: #16191C;
        color: #AAB2BF;
      }
      #workspaces button {
        padding: 0 5px;
      }
      "hyprland/workspaces": {
         "format": "{icon}",
         "on-scroll-up": "hyprctl dispatch workspace e+1",
         "on-scroll-down": "hyprctl dispatch workspace e-1"
      }
    '';
  };
}
