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
    thunderbird
    youtube-music
  ];
}
