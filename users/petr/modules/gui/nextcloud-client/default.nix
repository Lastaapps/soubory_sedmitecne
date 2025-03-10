{
  config,
  pkgs,
  ...
}:

let
  nextCloudConfigPath = "${config.home.homeDirectory}/dotfiles/users/petr/modules/gui/nextcloud-client/Nextcloud";
in
{
  # There were problems with starting the client this way, idk, autostart also works
  # services.nextcloud-client = {
  #   enable = true;
  #   startInBackground = false;
  # };
  home.packages = with pkgs; [ nextcloud-client ];

  xdg.configFile."Nextcloud".source = config.lib.file.mkOutOfStoreSymlink nextCloudConfigPath;
}
