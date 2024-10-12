{ config, lib, pkgs, ... }:

{
  # Use these for immutable configurations,
  # e.g. configurations not managed by GUI or CLI
  home.file = {
    "${config.xdg.configHome}/alacritty" = {
      source = dotfiles/alacritty;
      recursive = true;
    };
    ".arduino" = {
      source = dotfiles/arduino;
      recursive = true;
    };
    # TODO android studio
    # XDG autostart
    "${config.xdg.configHome}/awesome" = {
      source = dotfiles/awesome;
      recursive = true;
    };
    "bin" = {
      source = dotfiles/bin;
      recursive = true;
    };
    "${config.xdg.configHome}/clangd" = {
      source = dotfiles/clangd;
      recursive = true;
    };
    # "${config.xdg.configHome}/nvim" = {
    #   source = dotfiles/nvim;
    #   recursive = true;
    # };
    "${config.xdg.configHome}/ranger" = {
      source = dotfiles/ranger;
      recursive = true;
    };
    "${config.xdg.configHome}/tmux" = {
      source = dotfiles/tmux;
      recursive = true;
    };
    "${config.xdg.configHome}/zed" = {
      source = dotfiles/zed;
      recursive = true;
    };
    "${config.xdg.configHome}/zsh" = {
      source = dotfiles/zsh;
      recursive = true;
    };
  };

  # Use this section for mutable configurations
  # Used mostly for the GUI applications
  home.activation = {
    lnNextcloud = lib.hm.dag.entryAfter ["writeBoundary"] ''
	run ln -s $VERBOSE_ARG ${builtins.toPath ./dotfiles/Nextcloud} ${config.xdg.configHome} || true
    '';
    # TODO refactor
    lnNvim = lib.hm.dag.entryAfter ["writeBoundary"] ''
	run ln -s $VERBOSE_ARG ${builtins.toPath ./dotfiles/nvim} ${config.xdg.configHome} || true
    '';
  };
}
