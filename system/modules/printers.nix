{ pkgs, ... }:

{
  # Enable CUPS to print documents.
  services.printing = {
    # enable = true;
    drivers = with pkgs; [
      gutenprint
      gutenprintBin
      hplip
      samsung-unified-linux-driver
      splix
      brlaser
      brgenml1lpr
      cnijfilter2
    ];
  };
  # Printer network discovery
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
