{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.activation = {
    gitCloneProjects =
      lib.hm.dag.entryAfter
        [
          "writeBoundary"
          "installPackages"
        ]
        ''
          export PATH="${
            lib.makeBinPath (
              with pkgs;
              [
                git
                openssh
              ]
            )
          }:$PATH"

          PROJECTS_DIR=~/Projects
          if [ ! -d $PROJECTS_DIR ]; then
            mkdir $PROJECTS_DIR
          fi
          for REPO in LastaApps Menza Menza-backend StreetLamp fb-pages-discord-bot suz-aktuality-bot PyRigi NAC_paper advent-of-code Meteostanice; do
            if [ ! -d $PROJECTS_DIR/$REPO ]; then
              ${pkgs.git}/bin/git clone --recursive git@github.com:Lastaapps/$REPO.git $PROJECTS_DIR/$REPO
            fi
          done
        '';
  };
}
