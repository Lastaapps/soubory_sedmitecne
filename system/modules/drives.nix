{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    smartmontools

    cryptsetup
  ];
  services.smartd = {
    enable = true;
    notifications = {
      # mail = { ... };
      systembus-notify = {
        enable = true;
      };
      wall = {
        enable = true;
      };
      # Enabled when x11 is enabled
      # x11 = { enabled = true; };
      # test = true;
    };
    # https://wiki.archlinux.org/title/S.M.A.R.T.#smartd
    defaults.monitored = ''
      -a \
      -o on \
      -S on \
      -n standby,q \
      -s (S/../.././02|L/../../6/03) \
      # "-W 4,35,40 \
    '';
    extraOptions = [
      "-A /var/log/smartd/"
      "--interval=3600"
    ];
  };
}
