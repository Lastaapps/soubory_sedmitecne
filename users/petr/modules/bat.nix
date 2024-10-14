{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bat
  ];

  programs.bat = {
    enable = true;
  };

  home.shellAliases = {
    cat = "bat";
  };
}
