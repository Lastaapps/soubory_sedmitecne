let
  mkBorgBackup = sourceDirs: {
    location = {
      repositories = [
        "/mnt/data/Backup/BorgRepo"
        # "ssh://myuser@myserver.com/./personal-repo"
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
          "*/DCMI/20[0-9][0-9]*"
        ];
      };
    };
    storage.extraConfig = {
      compression = "zstd,9";
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
      ];
      "pictures" = mkBorgBackup [
        "/mnt/data/Phone"
        "/mnt/data/Pictures"
      ];
    };
  };
}
