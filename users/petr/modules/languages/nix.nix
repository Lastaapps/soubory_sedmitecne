{pkgs, ...}:

{
  home.packages = with pkgs; [
    # Language servers
    nixd
    nil
    nixfmt-rfc-style
  ];
}
