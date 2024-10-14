{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Language server
    neocmakelsp

    cmake
  ];
}
