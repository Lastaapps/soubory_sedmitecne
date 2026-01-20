{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ripgrep # recursively searches directories for a regex pattern
    fzf # A command-line fuzzy finder
    fd
    screen
    zoxide

    tldr

    # Serial
    minicom

    # PDF utils
    poppler-utils
    # Image conversion and others
    imagemagick
  ];
}
