{ ... }:
{
  imports = [
    ./general_programs.nix
    ./gnome

    ./libre-office.nix
    ./languages
    ./nextcloud-client
    ./safeeyes
    ./flameshot.nix

    ./bin.nix

    ./alacritty.nix
    ./bat.nix
    ./zsh
    ./direnv.nix

    ./git.nix
    ./gpg-agent.nix
    ./gtk.nix
    ./nvim
    ./ssh.nix

    ./octave.nix
    ./toolbox.nix
    ./vscode.nix
    ./zeal.nix
    ./zed

    ./java.nix
  ];
}
