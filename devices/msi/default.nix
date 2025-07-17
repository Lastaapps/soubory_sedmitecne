{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./graphics.nix
    ./ssd-fix.nix

    ../common/hdd.nix
    ../common/ssd.nix
  ];
}
