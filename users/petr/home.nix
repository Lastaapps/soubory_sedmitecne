{ config, pkgs, ... }:

{
  imports = [
    ./modules
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "petr";
  home.homeDirectory = "/home/petr";

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    BROWSER = "firefox";
    TERM = "alacritty";
    TERMINAL = "alacritty";
  };

  home.shellAliases = {
    mv = "mv -i";
    cat = "bat";
    lbc = "bc -l";
    xclip = "xclip -sel c";
    open = "xdg-open";

    # gradle
    libu = "./gradlew --no-configuration-cache versionCatalogUpdate --interactive";
    liba = "./gradlew --no-configuration-cache versionCatalogApplyUpdates";
    wrapperu = "./gradlew wrapper --no-configuration-cache --gradle-version";

    # misc
    pinggoogle = "ping -O google.com; ping -O 8.8.8.8";
  };

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
    ripgrep # recursively searches directories for a regex pattern
    fzf # A command-line fuzzy finder
    fd
    zoxide

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

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
