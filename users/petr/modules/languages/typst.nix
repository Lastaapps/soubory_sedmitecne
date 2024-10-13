{pkgs, ...}:

{
  home.packages = with pkgs; [
    # Language server
    typst-lsp
    typst-fmt

    typst
  ];
}
