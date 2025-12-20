{ ... }:

{
  # ssh -o PubkeyAuthentication=no -o PreferredAuthentications=password

  services.ssh-agent = {
    enable = true;
    defaultMaximumIdentityLifetime = 6 * 3600;
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        # Previous Home Assistant defaults
        forwardAgent = false;
        addKeysToAgent = "yes";
        compression = true;
      };
      "pi4" = {
        hostname = "lastope2.sh.cvut.cz";
        user = "admin";
        identityFile = "/home/petr/.ssh/pi4";
        port = 56943;
      };
      "asus" = {
        hostname = "192.168.1.1";
        user = "root";
        identityFile = "/home/petr/.ssh/asus_router";
      };
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "/home/petr/.ssh/github";
      };
      "gitlab.fit.cvut.cz" = {
        hostname = "gitlab.fit.cvut.cz";
        user = "lastope2";
        identityFile = "/home/petr/.ssh/gitlab_fit";
      };
      "git.sh.cvut.cz" = {
        hostname = "git.sh.cvut.cz";
        user = "lastope2";
        identityFile = "/home/petr/.ssh/gitlab_sh";
      };
      "oli" = {
        hostname = "10.10.48.90";
        user = "lastope2";
        identityFile = "/home/petr/.ssh/ni-oli";
      };
      "zybo" = {
        hostname = "10.10.51.194";
        user = "petalinux";
        identityFile = "/home/petr/.ssh/ni-oli";
      };
      # "fray" = {
      #   hostname = "fray1.fit.cvut.cz";
      #   user = "lastope2";
      #   # these two keys are not available in the Nix config
      #   hostKeyAlgorithms = [ "+ssh-rsa" ];
      #   publicAcceptedKeyTypes = [ "+ssh-rsa" ];
      # };
    };
  };
}
