{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # compiling
    clang_19
    (hiPrio gcc) # high priority used because both clang and gcc share the /bin/c++ binary
    lld

    # tools, lsp
    clang-tools_19

    # building
    cmake
    ninja
    gnumake

    # debugging
    gdb
    valgrind
  ];
}
