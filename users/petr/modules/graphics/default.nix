{ pkgs, ... }:
{
  imports = [

  ];
  home.packages = with pkgs; [
    digikam
    ffmpeg-full
    inkscape
    obs-studio
    vlc
    xournalpp
  ];
}
