{ ... }:
{
  imports = [
    ./general_programs.nix

    ./languages
    ./nextcloud-client

    ./bin.nix

    ./alacritty.nix
    ./bat.nix
    ./zsh

    ./git.nix
    ./gpg-agent.nix
    ./gtk.nix
    ./nvim
    ./ssh.nix

    ./octave.nix
    ./toolbox.nix
    ./safeeyes.nix
    ./vscode.nix
    ./zeal.nix
  ];
}
