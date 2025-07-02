{ inputs, pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    # This syntax be supported in the future HM releases
    # nativeMessagingHosts = {
    #   gsconnect = true;
    #   packages = [ pkgs.firefoxpwa ];
    # };
    nativeMessagingHosts = [
      pkgs.firefoxpwa
    ];
  };

  home.packages = with pkgs; [
    chromium
  ];
}
