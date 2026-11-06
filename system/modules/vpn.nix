{
  services.openvpn.servers = {
    fitVPN = {
      config = "config ${./fit-vpn.ovpn} ";
      autoStart = false;
    };
  };

  networking.wg-quick = {
    interfaces = {
      moje = {
        address = [
          "10.42.69.14/32"
        ];
        privateKeyFile = "/root/wg-privatekey";
        peers = [
          {
            publicKey = "nsjb53jtAo7p+Fnp/hjGHeqhww4D5FMth/0jgpii5FQ=";
            allowedIPs = [
              "10.42.69.0/24"
            ];
            endpoint = "lastope2.sh.cvut.cz:51821";
          }
        ];
      };
    };
  };
}
