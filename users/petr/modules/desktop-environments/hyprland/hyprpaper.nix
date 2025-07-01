{
  # Wallpaper
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      preload = [
        # do not prefetch large files
        "${./../wallpapers/main}"
      ];

      wallpaper = [
        # monitor, file
        ",${./../wallpapers/main}"
      ];
    };
  };
}
