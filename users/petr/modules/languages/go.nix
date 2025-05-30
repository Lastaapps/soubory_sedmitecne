{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Language server
    gopls

    # Debugger
    delve

    go
    goimports-reviser
  ];
}
