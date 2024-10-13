{pkgs, ...}:

{
  home.packages = with pkgs; [
    # Language server
    lua-language-server

    lua
    luarocks
  ];
}
