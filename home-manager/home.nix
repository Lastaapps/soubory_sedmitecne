{ config, pkgs, ... }:

{
  imports = [
    ./git.nix
    ./dotfiles.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "petr";
  home.homeDirectory = "/home/petr";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # General GUI
    thunderbird
    youtube-music
    nextcloud-client

    # misc
    cowsay
    fastfetch

    # CLI utils
    ripgrep  # recursively searches directories for a regex pattern
    fzf      # A command-line fuzzy finder
    fd       #
    zoxide   #

    # socials
    telegram-desktop
    element-desktop-wayland
    whatsapp-for-linux
    discord

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/petr/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "neovim";
  };

  gtk.gtk3.bookmarks = [
    "file:///home/petr/Documents"
    "file:///home/petr/Music"
    "file:///home/petr/Pictures"
    "file:///home/petr/Videos"
    "file:///home/petr/Downloads"
    "file:/// /"
    "file:///home/petr/Documents/CVUT CVUT"
    "file:///mnt/d/Android%20files%20sync Android"
    "file:///mnt/d/Android%20files%20sync/DCIM/Memes"
    "file:///home/petr/projects Projects"
    "file:///mnt/d D: Data"
    "file:///mnt/f F: Programs"
    "file:///mnt/d/Dokumenty/Filmy"
  ];

  # programs.alacritty = {
  #   enable = true;
  #   # custom settings
  #   settings = {
  #     env.TERM = "xterm-256color";
  #     font = {
  #       size = 12;
  #       draw_bold_text_with_bright_colors = true;
  #     };
  #     scrolling.multiplier = 5;
  #     selection.save_to_clipboard = true;
  #   };
  # };

  programs.ssh.enable = true;
  programs.ssh.matchBlocks = {
    "pi4" = {
      hostname = "lastope2.sh.cvut.cz";
      user = "admin";
      identityFile = "/home/petr/.ssh/pi4";
      port = 56943;
    };
    "github.com" = {
      hostname = "github.com";
      user = "git";
      identityFile = "/home/petr/.ssh/github";
    };
    "gitlab.fit.cvut.cz" = {
      hostname = "gitlab.fit.cvut.cz";
      user = "lastope2";
      identityFile = "/home/petr/.ssh/gitlab_fit";
    };
    "git.sh.cvut.cz" = {
      hostname = "git.sh.cvut.cz";
      user = "lastope2";
      identityFile = "/home/petr/.ssh/gitlab_sh";
    };
    # "fray" = {
    #   hostname = "fray1.fit.cvut.cz";
    #   user = "lastope2";
    #   hostKeyAlgorithms = [ "+ssh-rsa" ];
    #   publicAcceptedKeyTypes = [ "+ssh-rsa" ];
    # };
  };

  services.nextcloud-client.enable = true;
  services.nextcloud-client.startInBackground = true;

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
