{ config, ... }:

let
  safeEyesConfigPath = "${config.home.homeDirectory}/dotfiles/users/petr/modules/gui/safeeyes/safeeyes.json";
in
{
  services.safeeyes = {
    enable = true;
  };

  xdg.configFile."safeeyes/safeeyes.json".source =
    config.lib.file.mkOutOfStoreSymlink safeEyesConfigPath;
}
