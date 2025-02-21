{ pkgs, ... }:
{
  home.shellAliases = {
    lbc = "bc -l";
  };
  home.packages = with pkgs; [
    bc
    octave
  ];
}
