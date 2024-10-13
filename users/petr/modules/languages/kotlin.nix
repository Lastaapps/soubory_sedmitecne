{pkgs, ...}:

{
  home.packages = with pkgs; [
    # Language server
    kotlin-language-server

    kotlin-interactive-shell
    jdk21
  ];
}
