{ pkgs, ... }:

{
  # Needed by BFME & Wine
  hardware.graphics = {
    enable = true;
    # This provides the 32-bit drivers required by Wine/DirectX 9
    enable32Bit = true;

    extraPackages = with pkgs; [
      intel-media-driver # VA-API for Broadwell+
      intel-vaapi-driver
      libvdpau-va-gl
    ];

    # Ensures 32-bit versions of extra packages are also included
    extraPackages32 = with pkgs.pkgsi686Linux; [
      intel-media-driver
      intel-vaapi-driver
      libvdpau-va-gl
    ];
  };

  # Optional: Optimizes XWayland performance for older Intel iGPUs
  services.xserver.videoDrivers = [ "modesetting" ];
}
