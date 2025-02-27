{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ripgrep # recursively searches directories for a regex pattern
    fzf # A command-line fuzzy finder
    fd
    screen
    zoxide

    # Serial
    minicom
  ];
}
