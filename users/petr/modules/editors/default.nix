{ pkgs, ... }:
{
  imports = [
    ./nvim
    ./toolbox.nix
    ./vscode.nix
    ./zed
  ];
  home.packages = with pkgs; [
    saber
    zettlr

    texliveFull
  ];
}
