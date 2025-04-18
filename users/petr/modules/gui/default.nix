{ pkgs, ... }:
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
    gparted
    postman
    qbittorrent-enhanced
    thunderbird
    ventoy-bin-full
    youtube-music
  ];
}
