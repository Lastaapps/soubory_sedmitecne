{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Language server
    pyright
    ruff
    isort
    black

    python313
  ];
}
