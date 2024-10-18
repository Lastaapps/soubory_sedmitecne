{ pkgs, ... }:

{
  services.locate = {
    enable = true;
    locate = pkgs.mlocate;
    interval = "hourly";
    localuser = null; # as mlocate does not support this
  };
}
