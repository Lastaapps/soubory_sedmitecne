{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nvme-cli
  ];

  systemd.services.nvme-fix = {
    enable = true;
    description = "A custom service to run a bash command";
    wantedBy = [ "multi-user.target" ];
    script = ''
      while true; do sleep 5; nvme flush /dev/nvme0n1 -n 1 -v; nvme reset /dev/nvme0 -v; done
    '';
    restartIfChanged = true;
    serviceConfig = {
      restart = "on-failure";
    };
  };
}
