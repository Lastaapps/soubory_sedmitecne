{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    docker-compose
    docker-compose-language-service
  ];
  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
  };
}
