{ pkgs, ... }:

{
  services.locate = {
    enable = true;
    package = pkgs.mlocate;
    interval = "hourly";
    localuser = null; # as mlocate does not support this
  };
}
