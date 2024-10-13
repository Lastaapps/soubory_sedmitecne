{pkgs, ...}:

{
  home.packages = with pkgs; [
    # compiling
    clang
    (hiPrio gcc) # high priority used because both clang and gcc share the /bin/c++ binary
    lld

    # tools, lsp
    clang-tools

    # building
    cmake
    ninja
    gnumake

    # debugging
    gdb
    valgrind
  ];
}
