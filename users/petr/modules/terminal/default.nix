{ pkgs, ... }:
{
  imports = [
    ./alacritty.nix
    ./bat.nix
    ./direnv.nix
    ./zsh
  ];
  home.packages = with pkgs; [
    ranger
    tmux
  ];
}
