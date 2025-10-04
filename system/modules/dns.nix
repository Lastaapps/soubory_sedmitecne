# https://nixos.wiki/wiki/Encrypted_DNS
{ ... }:

{
  networking = {
    nameservers = [
      "127.0.0.1"
      "::1"
    ];
    # If using dhcpcd:
    # dhcpcd.extraConfig = "nohook resolv.conf";
    # If using NetworkManager:
    networkmanager.dns = "none";
  };

  # Require:
  services.resolved.enable = false;

  # Enables encrypted DNS
  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      ipv6_servers = true;
      require_dnssec = true;
      http3 = true;

      # TODO Enable in 25.11
      # monitoring_ui = {
      #   enabled = true;
      #   listen_address = "127.0.0.1:5335";
      #   username = "admin";
      #   password = "changeme-nope";
      #   tls_certificate = "";
      #   tls_key = "";
      #   enable_query_log = true;
      #   privacy_level = 0;
      # };

      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
      };

      # You can choose a specific set of servers from https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v3/public-resolvers.md
      server_names = [
        "nic.cz"
        "nic.cz-ipv6"
        "cloudflare-security"
        "cloudflare-security-ipv6"
        "google"
        "google-ipv6"
      ];
    };
  };

  systemd.services.dnscrypt-proxy2.serviceConfig = {
    StateDirectory = "dnscrypt-proxy";
  };
}
