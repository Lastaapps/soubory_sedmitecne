{ pkgs, pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs; [
    wineWow64Packages.unstableFull
    wineWow64Packages.waylandFull
    winetricks
  ];
}
