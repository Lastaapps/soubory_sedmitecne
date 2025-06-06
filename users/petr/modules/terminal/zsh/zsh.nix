{ pkgs, ... }:

{
  # https://home-manager-options.extranix.com/?query=zsh&release=master
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion = {
      enable = true;
      strategy = [
        # in this order
        "match_prev_cmd"
        "completion"
        "history"
      ];
    };
    syntaxHighlighting.enable = true;

    history = {
      size = 10000;
      ignoreAllDups = true;
      expireDuplicatesFirst = true;
      ignorePatterns = [
        "rm *"
        "pkill *"
        "cp *"
      ];
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        # "thefuck" # conflicts with sudo
        "sudo"
        "fzf"
        "vi-mode"
      ];
      theme = "robbyrussell";
    };

    initContent = ''
      source "${./zshrc}"
      source "${./fzf.zsh}"
      source "${pkgs.git}/share/git/contrib/completion/git-prompt.sh"
    '';
  };
}
