{ ... }:

{
  # When adding a new shell, always enable the shell system-wide, even if it's
  # already enabled in your Home Manager configuration, otherwise it won't
  # source the necessary files.
  programs.zsh.enable = true;

  # Let's keep it for scripts
  # Also it's enabled by default
  # programs.bash.enable = true;

  environment.shellAliases = {
    l = "ls -alh";
    ll = "ls -l";
    ls = "ls --color=tty";
    vim = "nvim";
    rm = "rm -i";
    ns = "nix-shell";
  };
}
