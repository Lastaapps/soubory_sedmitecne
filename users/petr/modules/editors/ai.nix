{ pkgs, pkgs-unstable, ... }:

{
  programs.antigravity-cli = {
    enable = true;
    enableMcpIntegration = true;
    package = pkgs-unstable.antigravity-cli;
  };

  home.packages = with pkgs; [
  ];
}
