# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "nvme"
    "usb_storage"
    "sd_mod"
    "rtsx_usb_sdmmc"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.supportedFilesystems = [
    "btrfs"
    "ext4"
    "ntfs"
  ];

  services.btrfs = {
    autoScrub = {
      enable = true;
      interval = "monthly";
      fileSystems = [
        "/"
        "/home"
      ];
    };
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/B56E-0176";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/1d2f1e9e-57cd-4a1f-8205-9ca0aa95fac6";
    fsType = "btrfs";
    options = [
      "subvol=@"
      # Access times are not written to drive at all
      # https://wiki.archlinux.org/title/Fstab#atime_options
      "noatime"
      "nodiratime"
      "commit=60"
    ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/fa8e7f11-004a-49a0-8eb6-f4c9545f7973";
    fsType = "btrfs";
    options = [
      "noatime"
      "nodiratime"
      "commit=60"
    ];
  };

  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-uuid/a0c9ba94-4df6-421d-8ff5-bd9c3d432cec";
    fsType = "btrfs";
    options = [
      "noatime"
      "nodiratime"
      "commit=60"
      "nodatacow"
      "autodefrag"
      "compress=zstd"
    ];
  };

  ##############################################################################
  # https://nixos.wiki/wiki/Swap
  # https://wiki.archlinux.org/title/Zram
  # https://search.nixos.org/options?query=zram
  # Pages, that are uncompressible, are swapped to a disk anyway,
  # otherwise zram should be preferred by the Kernel.
  ##############################################################################
  zramSwap = {
    enable = true;
    # default is 50.
    # I noticed that often the zram swap is filled (8GB),
    # while the compressed size is <1GB.
    # So I want to abuse the feature even more.
    # This should be disabled in case I need quick access to the RAM.
    memoryPercent = 80;
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/ec6daf78-a2eb-48c3-b145-a6eacc7dee31"; }
  ];

  boot.kernel.sysctl = {
    # Taken from ArchWiki, only use with zram
    # default value: 60 (cat /proc/sys/vm/swappiness)
    "vm.swappiness" = 180;
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 125;
    "vm.page-cluster" = 0;
  };
  ##############################################################################

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp3s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp2s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
