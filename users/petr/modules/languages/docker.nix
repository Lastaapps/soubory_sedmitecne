{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Language server
    docker-ls

    docker
  ];
}
