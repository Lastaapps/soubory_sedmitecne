{ config, ... }:

{
  services.safeeyes = {
    enable = true;
  };

  home.file = {
    "${config.xdg.configHome}/safeeyes/safeeyes.json".source = ./safeeyes.json;
  };
}
