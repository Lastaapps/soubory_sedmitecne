# https://github.com/NixOS/nixos-hardware/blob/master/common/pc/laptop/hdd/default.nix
{ lib, ... }:

{
  # Hard disk protection if the laptop falls:
  # Works only on ThinkPads
  # services.hdapsd.enable = lib.mkDefault true;
}
