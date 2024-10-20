{ ... }:
{
  imports = [
    ./general_programs.nix

    ./languages
    ./nextcloud-client
    ./safeeyes

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
    ./vscode.nix
    ./zeal.nix
  ];
}
