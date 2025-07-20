{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nvme-cli
  ];

  systemd.services.nvme-fix = {
    enable = true;
    description = "Prevents SSD from overheating somehow";
    wantedBy = [ "multi-user.target" ];
    # 5 seconds still overheats while additional load is applied on the machine
    # Command nvme flush /dev/nvme0n1 -n 1 -v; can be also added
    script = ''
      while true; ${pkgs.nvme-cli}/bin/nvme reset /dev/nvme0 -v; do sleep 3; done
    '';
    restartIfChanged = true;
    serviceConfig = {
      restart = "on-failure";
    };
  };
}
