{ pkgs, ... }:
{
  imports = [
    ./cli_utils.nix
    ./drive.nix
    ./git.nix
    ./gpg-agent.nix
    ./math.nix
    ./network.nix
    ./ssh.nix
    ./tmux
  ];
  home.packages = with pkgs; [
    nvme-cli
    pdftk
  ];
}
