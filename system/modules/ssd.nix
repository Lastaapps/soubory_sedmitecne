{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # provides systemctl
    # sudo smartctl /dev/sda --all
    smartmontools
  ];
}
