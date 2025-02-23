{
  lib,
  config,
  pkgs,
  ...
}:

{
  # There were problems with starting the client this way, idk, autostart also works
  # services.nextcloud-client = {
  #   enable = true;
  #   startInBackground = false;
  # };
  home.packages = with pkgs; [ nextcloud-client ];

  # Link configs to the correct dir, they may be mutable
  home.activation = {
    lnNextcloud = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      run unlink $VERBOSE_ARG ${config.xdg.configHome}/Nextcloud || true
      run ln -s $VERBOSE_ARG ~/dotfiles/users/petr/modules/gui/nextcloud-client/Nextcloud ${config.xdg.configHome} || true
    '';
  };
}
