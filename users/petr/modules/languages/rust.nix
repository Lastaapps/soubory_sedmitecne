{pkgs, ...}:

{
  home.packages = with pkgs; [
    # Language server
    rust-analyzer
    rustfmt

    rustc
    cargo
  ];
}
