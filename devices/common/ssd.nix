# https://github.com/NixOS/nixos-hardware/blob/master/common/pc/ssd/default.nix
{ lib, ... }:

{
  services.fstrim.enable = lib.mkDefault true;
}
