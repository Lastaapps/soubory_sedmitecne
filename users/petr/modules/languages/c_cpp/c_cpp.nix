{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # compiling
    clang # clang_{version}
    (hiPrio gcc) # high priority used because both clang and gcc share the /bin/c++ binary
    lld

    # tools, lsp
    clang-tools # clang-tools_{version}

    # building
    cmake
    ninja
    gnumake

    # debugging
    gdb
    valgrind
  ];
}
