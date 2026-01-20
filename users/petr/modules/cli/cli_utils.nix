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
    # Change text file encoding: recode windows-1250..utf8 < in.srt > out.srt
    recode
  ];
}
