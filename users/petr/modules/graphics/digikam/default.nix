{
  config,
  pkgs,
  ...
}:

let
  digikamrcPath = "${config.home.homeDirectory}/dotfiles/users/petr/modules/graphics/digikam/digikamrc";
  digikamSystemrcPath = "${config.home.homeDirectory}/dotfiles/users/petr/modules/graphics/digikam/digikam_systemrc";
in
{
  imports = [ ];
  home.packages = with pkgs; [
    digikam
  ];

  xdg.configFile."digikamrc".source = config.lib.file.mkOutOfStoreSymlink digikamrcPath;
  xdg.configFile."digikam_systemrc".source = config.lib.file.mkOutOfStoreSymlink digikamSystemrcPath;
}
