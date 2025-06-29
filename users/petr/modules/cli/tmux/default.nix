{ pkgs, ... }:

let
  config = builtins.readFile ./tmux.conf;
in
{
  # https://wiki.archlinux.org/title/Tmux
  home.packages = with pkgs; [
    wl-clipboard
  ];

  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      battery
      better-mouse-mode
      continuum
      online-status
      open
      prefix-highlight
      resurrect
      sensible
      urlview
      yank
    ];
    clock24 = true;
    # keyMode = "vi";
    # mouse = true;
    # baseIndex = 1;
    # prefix = "C-a";
    # shortcut = "a";
    # terminal = "alacritty";

    # tmuxinator = {
    #   enable = true;
    # };
    # tmuxp = {
    #   enable = true;
    # };
    extraConfig = config;
  };

  # Arch wiki
  # systemd.user.services.tmux = {
  #   Unit = {
  #     Description = "Preloads tmux session for %I";
  #     After = "graphical-session.target";
  #   };
  #   Install = {
  #     WantedBy = [ "graphical-session.target" ];
  #   };
  #   Service = {
  #     Type = "forking";
  #     ExecStart = "${pkgs.tmux}/bin/tmux new-session -s %I -d";
  #     ExecStop = "${pkgs.tmux}/bin/tmux kill-session -t %I";
  #     WorkingDirectory = "%h";
  #   };
  # };

}
