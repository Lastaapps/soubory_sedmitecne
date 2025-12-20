{ ... }:
{
  imports = [
    ./dns.nix
    ./docker.nix
    ./drives.nix
    ./dynamic_linking.nix
    ./fonts.nix
    ./gdm.nix
    ./gnome.nix
    # ./hyprland.nix
    ./locate.nix
    ./locale_keyboard.nix
    ./printers.nix
    ./programs.nix
    ./shells.nix
    ./sound.nix
    ./syncthing.nix
    ./users.nix
    ./vpn.nix
    ./wine.nix
  ];
}
