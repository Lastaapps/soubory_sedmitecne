{ ... }:
{
  imports = [
    ./languages
    ./nextcloud-client

    ./bin.nix

    ./alacritty.nix
    ./bat.nix
    ./zoxide.nix

    ./git.nix
    ./gpg-agent.nix
    ./gtk.nix
    ./nvim
    ./ssh.nix

    ./octave.nix
    ./toolbox.nix
    ./safeeyes.nix
    ./vscode.nix
  ];
}
