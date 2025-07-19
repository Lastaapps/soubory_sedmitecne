{ pkgs, ... }:
{
  imports = [

  ];
  home.packages = with pkgs; [
    exiftool
    digikam
    ffmpeg-full
    obs-studio
    vlc

    drawio
    inkscape
    xournalpp
  ];
}
