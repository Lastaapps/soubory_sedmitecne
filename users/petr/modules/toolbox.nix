{pkgs, ...}:

{
  # Can be made fully stateless, but it hurts...
  home.packages = with pkgs; [
    jetbrains-toolbox
  ];
}

