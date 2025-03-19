{ pkgs, pkgs-unstable, ... }:

{
  programs.poetry = {
    enable = true;
    package = pkgs-unstable.poetry;
  };

  home.packages = with pkgs; [
    # Language server
    pyright
    ruff
    isort
    black

    uv

    python313
  ];
}
