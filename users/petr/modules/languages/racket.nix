{pkgs, ...}:

{
  home.packages = with pkgs; [
    # Language server
    racket
  ];
}
