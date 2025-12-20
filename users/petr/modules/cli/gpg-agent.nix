{ ... }:

{
  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = false; # does not work, ssh-agent used instead
  };
}
