{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Language server
    docker-ls
    dockerfile-language-server

    docker
  ];
}
