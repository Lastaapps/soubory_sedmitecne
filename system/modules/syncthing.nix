{
  pkgs,
  ...
}:

{
  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true"; # Don't create default ~/Sync folder

  services = {
    syncthing = {
      enable = true;
      user = "petr";
      dataDir = "/home/petr";
      configDir = "/home/petr/.config/syncthing";
      overrideDevices = false; # overrides any devices added or deleted through the WebUI
      overrideFolders = false; # overrides any folders added or deleted through the WebUI
      settings = {
        # devices = {
        #   "device1" = { id = "DEVICE-ID-GOES-HERE"; };
        #   "device2" = { id = "DEVICE-ID-GOES-HERE"; };
        # };
        # folders = {
        #   "Documents" = {         # Folder ID in Syncthing, also the name of folder (label) by default
        #     path = "/home/myusername/Documents";    # Which folder to add to Syncthing
        #     devices = [ "device1" "device2" ];      # Which devices to share the folder with
        #   };
        #   "Example" = {
        #     label = "Private";                      # Optional label for the folder
        #     path = "/home/myusername/Example";
        #     devices = [ "device1" ];
        #     ignorePerms = false;  # By default, Syncthing doesn't sync file permissions. This line enables it for this folder.
        #   };
        # };

        options = {
          listenAddresses = [
            "default"
            "relay://lastope2.sh.cvut.cz:22067/?id=Z22QLT3-HRNIYKO-GIFDCTU-ZDDDIZ2-LCNNQA2-INDOG2J-2COAGDN-CTH3BQJ&networkTimeout=2m0s&pingInterval=1m0s&statusAddr=%3A22070"
          ];
          globalAnnounceServers = [
            "default"
            "https://lastope2.sh.cvut.cz:42430/"
          ];
          urAccepted = 3;
        };
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 22000 ];
  networking.firewall.allowedUDPPorts = [
    22000
    21027
  ];
}
