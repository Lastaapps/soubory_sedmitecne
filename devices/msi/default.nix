{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./graphics.nix

    ../common/hdd.nix
    ../common/ssd.nix
  ];
}
