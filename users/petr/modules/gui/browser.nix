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

    # https://github.com/0xc000022070/zen-browser-flake/issues/28
    (inputs.zen-browser.packages.${system}.default.override {
      nativeMessagingHosts = [ pkgs.firefoxpwa ];
    })
  ];
}
