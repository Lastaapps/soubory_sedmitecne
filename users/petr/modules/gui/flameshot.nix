{ pkgs, ... }:
{
  services.flameshot = {
    enable = true;
    # https://github.com/flameshot-org/flameshot/blob/master/flameshot.example.ini
    settings = { };
  };

  home.packages = with pkgs; [
    xdg-desktop-portal
    xdg-desktop-portal-gnome
  ];
}
