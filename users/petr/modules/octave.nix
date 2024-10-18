# Matlab replacement - recommended for optimization
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    octave
  ];
}
