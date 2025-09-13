{ pkgs, ... }:

{
  gtk = {
    enable = true;
    cursorTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };

  gtk.gtk3.bookmarks = [
    "file:///home/petr/Documents"
    "file:///home/petr/Music"
    "file:///home/petr/Pictures"
    "file:///home/petr/Videos"
    "file:///home/petr/Downloads"
    "file:///home/petr/Phone"
    "file:/// /"
    "file:///home/petr/Documents/CVUT CVUT"
    "file:///mnt/data/Android%20files%20sync Android"
    "file:///mnt/data/Android%20files%20sync/DCIM/Memes"
    "file:///home/petr/projects Projects"
    "file:///mnt/data D: Data"
    "file:///mnt/data/Movies Filmy"
  ];
}
