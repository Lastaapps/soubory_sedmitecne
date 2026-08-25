let
  mkBorgBackup = sourceDirs: {
    location = {
      repositories = [
        "/mnt/data/Backup/BorgRepo"
        "ssh://pi4/raid/backups/MSI_BorgRepo"
      ];
      sourceDirectories = sourceDirs;
      extraConfig = {
        exclude_patterns = [
          "*/.bloop"
          "*/.build"
          "*/_build"
          "*/build"
          "*/BuildTools"
          "*/*.db*"
          "*/generator/testdata"
          "*/.git"
          "*/.gradle"
          "*/.kotlin"
          "*/*log*"
          "*/logs"
          "*/mcaselector"
          "*/node_modules"
          "*/PID"
          "*/pid_data"
          "*/petalinux"
          "*/__pycache__"
          "*/server_backup"
          "*/Servers/*/bundler"
          "*/Servers/*/libraries"
          "*/Servers/*/versions"
          "*/.stack-work"
          "*/.stfolder"
          "*/.sync"
          "*/target"
          "*/.thumbnails"
          "*/uni*"
          "*/.venv*"
          "*/venv*"
          "*/precomputed"
          "*/runs"
          "*/backup"
          "*/Blackmagic Camera"
          "*/graphs_store"
          "*/benchmarks"
        ];
      };
    };
    storage = {
      extraConfig = {
        compression = "zstd,9";
      };
      # TODO build scrip that creates this temporarily from user input
      encryptionPasscommand = "cat /home/petr/borgmatic_password";
    };
    retention = {
      keepMonthly = 1;
      keepYearly = 4;
    };
    consistency.checks = [
      {
        name = "repository";
        frequency = "1 months";
      }
      {
        name = "archives";
        frequency = "1 months";
      }
      {
        name = "data";
        frequency = "1 years";
      }
    ];
  };
in
{
  programs.borgmatic = {
    enable = true;
    backups = {
      # borgmatic config validate
      # borgmatic repo-create --encryption repokey (see based on hardware age)
      # borgmatic create --verbosity 1 --list --stats
      "main" = mkBorgBackup [
        "/mnt/data/Documents"
        "/mnt/data/Minecraft"
        "/mnt/data/Videos"
        "/mnt/data/Projects/AndroidStudioProjects"
        "/mnt/data/Projects/NetBeansProjects"
        "/mnt/data/Projects/Archive"
        "/mnt/data/Projects/eagle"
        "/home/petr/dotfiles"
        "/home/petr/Projects"
        "/mnt/data/Phone/Diary"
        "/mnt/data/Phone/Documents"
        "/mnt/data/Phone/Download"
        "/mnt/data/Phone/Voice Recorder"
      ];
      "pictures" = mkBorgBackup [
        "/mnt/data/Phone/DCIM"
        "/mnt/data/Phone/Pictures"
        "/mnt/data/Pictures"
      ];
    };
  };
}
