{
  # Blue light filter
  # https://wiki.hypr.land/Hypr-Ecosystem/hyprsunset/
  # https://home-manager-options.extranix.com/?query=hyprsunset
  services.hyprsunset = {
    enable = true;
    transitions = {
      sunrise = {
        calendar = "*-*-* 06:00:00";
        requests = [
          [
            "temperature"
            "6500"
          ]
          [ "gamma 100" ]
        ];
      };
      sunset = {
        calendar = "*-*-* 19:00:00";
        requests = [
          [
            "temperature"
            "3500"
          ]
        ];
      };
    };
  };
}
