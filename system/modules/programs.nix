{ pkgs, ... }:

{
  # Install firefox.
  programs.firefox.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
  environment.variables.EDITOR = "nvim";

  # List packages installed in system profile.
  # To search, run: $ nix search wget
  environment.systemPackages = with pkgs; [
    dbus
    git
    neovim
    nix-search-cli
    python3

    # tops
    htop
    iotop
    iftop

    # misc
    bat
    file
    which
    tree
    gnused
    gawk
    zstd
    gnupg
    wl-clipboard # Wayland clipboard tool, required by nvim

    # man pages
    man-pages
    man-pages-posix

    # networking tools
    dnsutils # `dig` + `nslookup`
    iperf3
    networkmanagerapplet # nm-connection-editor for NetworkManager GUI management
    nmap # A utility for network discovery and security auditing
    ldns # replacement of `dig`, it provide the command `drill`
    openssh # ssh
    socat # replacement of openbsd-netcat
    wget

    # archives
    gnutar
    zip
    xz
    unzip
    rar

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
  ];
}
