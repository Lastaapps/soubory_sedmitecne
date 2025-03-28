{ ... }:
{
  imports = [
    ./dns.nix
    ./docker.nix
    ./dynamic_linking.nix
    ./gdm.nix
    ./gnome.nix
    ./locate.nix
    ./locale_keyboard.nix
    ./printers.nix
    ./programs.nix
    ./shells.nix
    ./sound.nix
    ./ssd.nix
    ./syncthing.nix
    ./users.nix
    ./vpn.nix
    ./wine.nix
  ];
}
