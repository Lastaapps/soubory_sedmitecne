{pkgs, ...}:

{
  home.packages = with pkgs; [
    # Language server
    sqls

    sqlite
  ];
}
