{ lib, pkgs, ... }:
{
  ### Resources
  # Generally, the docs really suck...
  # https://github.com/NixOS/nixos-hardware/blob/master/msi/gl62/default.nix
  # https://wiki.nixos.org/wiki/Graphics
  # https://nixos.wiki/wiki/Accelerated_Video_Playback
  # https://wiki.nixos.org/wiki/NVIDIA
  # https://wiki.archlinux.org/title/Vulkan
  # https://wiki.nixos.org/wiki/Intel_Graphics
  # https://wiki.nixos.org/wiki/AMD_GPU
  # https://wiki.nixos.org/wiki/CUDA

  # nvidia
  hardware.nvidia = {
    prime = {
      intelBusId = lib.mkDefault "PCI:0:2:0";
      nvidiaBusId = lib.mkDefault "PCI:1:0:0";
      #amdgpuBusId = "PCI:54:0:0"; # If you have an AMD iGPU
    };
  };

  hardware.graphics = {
    enable = true;

    extraPackages = with pkgs; [
      # support for VA-API
      # intel-vaapi-driver # also vaapiIntel, unmaintained alternative
      # intel-media-driver

      # Quick Sync Video
      # vpl-gpu-rt # On Intel 10th gen onwards

      # VDPAU (maybe obsolete)
      libvdpau-va-gl # VDPAU driver with OpenGL/VAAPI backend
    ];
  };
}
