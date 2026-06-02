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
    filezilla
    persepolis
    gparted
    postman
    qbittorrent-enhanced
    pear-desktop # youtube-music
    thunderbird
    ventoy-full
    yt-dlg

    # C# / Xamarin decompiler
    # ilspycmd
  ];
  nixpkgs.config.permittedInsecurePackages = [
    "ventoy-1.1.12"
  ];
}
