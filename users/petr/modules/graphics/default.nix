{ pkgs, ... }:
{
  imports = [
    ./digikam
  ];
  home.packages = with pkgs; [
    exiftool
    ffmpeg-full
    obs-studio
    vlc

    drawio
    inkscape
    xournalpp
  ];
}
