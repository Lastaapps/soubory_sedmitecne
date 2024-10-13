{pkgs, ...}:

{
  home.packages = with pkgs; [
    # Language server
    pyright
    black

    python313
  ];
}
