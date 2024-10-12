{lib, config, ...}:

{
  services.nextcloud-client.enable = true;
  services.nextcloud-client.startInBackground = true;

  # Link configs to the correct dir, they may be mutable
  home.activation = {
    lnNextcloud = lib.hm.dag.entryAfter ["writeBoundary"] ''
      run unlink $VERBOSE_ARG ${config.xdg.configHome}/Nextcloud || true
      run ln -s $VERBOSE_ARG ~/dotfiles/users/petr/modules/nextcloud-client/Nextcloud ${config.xdg.configHome} || true
    '';
  };
}
