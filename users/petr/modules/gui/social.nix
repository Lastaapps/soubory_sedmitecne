{ pkgs, ... }:
{
  home.packages = with pkgs; [
    telegram-desktop
    element-desktop
    whatsapp-for-linux
    discord
    signal-desktop
  ];
}
