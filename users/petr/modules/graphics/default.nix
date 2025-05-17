{ pkgs, ... }:
{
  imports = [

  ];
  home.packages = with pkgs; [
    digikam
    ffmpeg-full
    obs-studio
    vlc

    drawio
    inkscape
    xournalpp
  ];
}
