{ lib, config, pkgs-unstable, ... }:
{
  home.packages = with pkgs-unstable; [
    zed-editor
  ];

  home.activation = {
    lnZed = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      run unlink $VERBOSE_ARG ${config.xdg.configHome}/zed || true
      run ln -s $VERBOSE_ARG ~/dotfiles/users/petr/modules/zed ${config.xdg.configHome} || true
    '';
  };
}
