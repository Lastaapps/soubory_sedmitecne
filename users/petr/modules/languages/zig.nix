{pkgs, ...}:

{
  home.packages = with pkgs; [
    # Language server
    zls

    zig
  ];
}
