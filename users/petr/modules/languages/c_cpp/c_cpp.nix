{ pkgs, ... }:

{
  home.packages =
    (with pkgs.llvmPackages_21; [
      clang
      clang-tools
    ])
    ++ (with pkgs; [
      (hiPrio gcc) # high priority used because both clang and gcc share the /bin/c++ binary
      lld

      # building
      cmake
      ninja
      gnumake

      # debugging
      gdb
      valgrind

      stdman
      cppreference-doc

      compiledb
    ]);
}
