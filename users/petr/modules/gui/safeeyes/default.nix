{ config, ... }:

let
  safeEyesConfigPath = "${config.home.homeDirectory}/dotfiles/users/petr/modules/gui/safeeyes/safeeyes.json";
in
{
  services.safeeyes = {
    enable = true;
  };
  services.snixembed = {
    enable = true;

    beforeUnits = [
      # https://github.com/slgobinath/SafeEyes/wiki/How-to-install-backend-for-Safe-Eyes-tray-icon
      "safeeyes.service"
    ];
  };

  xdg.configFile."safeeyes/safeeyes.json".source =
    config.lib.file.mkOutOfStoreSymlink safeEyesConfigPath;
}
