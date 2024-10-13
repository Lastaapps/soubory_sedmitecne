{pkgs, ...}:

{
  home.packages = with pkgs; [
    # Language server
    texlab

    # texliveFull
  ];
}
