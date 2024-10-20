# https://github.com/NixOS/nixos-hardware/blob/master/common/pc/laptop/hdd/default.nix
{ lib, ... }:

{
  # Hard disk protection if the laptop falls:
  services.hdapsd.enable = lib.mkDefault true;
}
