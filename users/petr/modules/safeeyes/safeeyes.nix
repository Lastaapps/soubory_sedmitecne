{ config, lib, ... }:

{
  services.safeeyes = {
    enable = true;
  };

  # home.file = {
  #   "${config.xdg.configHome}/safeeyes/safeeyes.json".source = ./safeeyes.json;
  # };
  home.activation = {
    lnSafeeyes = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      run unlink $VERBOSE_ARG ${config.xdg.configHome}/safeeyes/safeeyes.json || true
      run ln -s $VERBOSE_ARG ~/dotfiles/users/petr/modules/safeeyes/safeeyes.json ${config.xdg.configHome}/safeeyes || true
    '';
  };
}
