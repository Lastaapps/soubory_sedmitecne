{
  services.openvpn.servers = {
    fitVPN = {
      config = ''config ${./fit-vpn.ovpn} '';
      autoStart = false;
    };
  };
}
