{ pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.petr = {
    isNormalUser = true;
    description = "Petr";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    # packages = with pkgs; [ ];
  };
  users.users.petr.shell = pkgs.zsh;
}
