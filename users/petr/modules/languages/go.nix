{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Language server
    gopls

    go
  ];
}
