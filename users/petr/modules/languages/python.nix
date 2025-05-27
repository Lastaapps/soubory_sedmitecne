{ pkgs, ... }:

{
  programs.poetry = {
    enable = true;
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
