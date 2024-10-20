{ ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../common/hdd.nix
    ../common/ssd.nix
  ];
}
