{ pkgs, pkgs-unstable, ... }:
{
  imports = [
    ./browser.nix
    ./flameshot.nix
    ./gtk.nix
    ./nextcloud-client
    ./safeeyes
    ./social.nix
    ./zeal.nix
  ];
  home.packages = with pkgs; [
    anki-bin
    gparted
    postman
    qbittorrent-enhanced
    pkgs-unstable.thunderbird
    ventoy-full
    youtube-music
  ];
  nixpkgs.config.permittedInsecurePackages = [
    "ventoy-1.1.07"
  ];
}
