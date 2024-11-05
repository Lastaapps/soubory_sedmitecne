{ pkgs, pkgs-unstable, ... }:

{
  home.packages = with pkgs; [
    # compiling
    pkgs-unstable.clang_19
    (hiPrio gcc) # high priority used because both clang and gcc share the /bin/c++ binary
    lld

    # tools, lsp
    pkgs-unstable.clang-tools_19

    # building
    cmake
    ninja
    gnumake

    # debugging
    gdb
    valgrind
  ];
}
