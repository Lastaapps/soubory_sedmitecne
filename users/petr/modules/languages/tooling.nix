{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Linters
    vale
    vale-ls
  ];
}
