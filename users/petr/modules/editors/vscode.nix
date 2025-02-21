{ pkgs, ... }:

{
  # nix run github:nix-community/nix-vscode-extensions# -- --list-extensions

  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    # mutableExtensionsDir = false;
    mutableExtensionsDir = true;

    # extensions =
    #   with pkgs.open-vsx;
    #   [
    #     # https://raw.githubusercontent.com/nix-community/nix-vscode-extensions/master/data/cache/open-vsx-latest.json
    #     dracula-theme.theme-dracula
    #     vscodevim.vim
    #     yzhang.markdown-all-in-one
    #     rust-lang.rust-analyzer
    #   ]
    #   ++ (with pkgs.vscode-marketplace; [
    #     # https://raw.githubusercontent.com/nix-community/nix-vscode-extensions/master/data/cache/vscode-marketplace-latest.json
    #     ms-python.python
    #     ms-python.debugpy
    #     ms-toolsai.jupyter
    #     ms-vscode.cpptools-extension-pack
    #     # https://discourse.nixos.org/t/vscode-extensions-setup/1801
    #     # ms-vscode.cpptools
    #   ]);

    # Settings
    userSettings = {
      # General
      "editor.fontSize" = 16;
      "editor.fontFamily" = "'Jetbrains Mono', 'monospace', monospace";
      "terminal.integrated.fontSize" = 14;
      "terminal.integrated.fontFamily" = "'JetBrainsMono Nerd Font', 'monospace', monospace";
      "window.zoomLevel" = 1;
      "editor.multiCursorModifier" = "ctrlCmd";
      "workbench.startupEditor" = "none";
      "explorer.compactFolders" = false;
      # Whitespace
      "files.trimTrailingWhitespace" = true;
      "files.trimFinalNewlines" = true;
      "files.insertFinalNewline" = true;
      "diffEditor.ignoreTrimWhitespace" = false;
      # Git
      "git.enableCommitSigning" = true;
      "git-graph.repository.sign.commits" = true;
      "git-graph.repository.sign.tags" = true;
      "git-graph.repository.commits.showSignatureStatus" = true;
      # Styling
      "window.autoDetectColorScheme" = true;
      "workbench.preferredDarkColorTheme" = "Default Dark Modern";
      "workbench.preferredLightColorTheme" = "Default Light Modern";
      "workbench.iconTheme" = "material-icon-theme";
      "material-icon-theme.activeIconPack" = "none";
      "material-icon-theme.folders.theme" = "classic";
      # Other
      "telemetry.telemetryLevel" = "off";
      "update.showReleaseNotes" = false;
    };
  };
}
