{ pkgs, ... }:

{
  gtk = {
    enable = true;

    cursorTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    # TODO enable in unstable NixOS 25.11
    # colorScheme = "dark";

    gtk3.bookmarks = [
      "file:/// /"
      "file:///home/petr/Documents/MFF MFF"
      "file:///home/petr/Documents/CVUT CVUT"
      "file:///home/petr/Downloads Downloads"
      "file:///home/petr/Documents Documents"
      "file:///home/petr/Phone/DCIM/Memes Memes"
      "file:///home/petr/Projects Projects"
      "file:///home/petr/Phone Phone"
      "file:///mnt/data D: Data"
    ];
  };
}
