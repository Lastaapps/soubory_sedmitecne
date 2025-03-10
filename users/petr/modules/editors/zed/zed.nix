{
  config,
  pkgs-unstable,
  ...
}:

let
  zedConfigPath = "${config.home.homeDirectory}/dotfiles/users/petr/modules/editors/zed";
in
{
  home.packages = with pkgs-unstable; [
    zed-editor
  ];

  xdg.configFile."zed".source = config.lib.file.mkOutOfStoreSymlink zedConfigPath;
}
