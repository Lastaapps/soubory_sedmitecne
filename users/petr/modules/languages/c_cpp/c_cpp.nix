{
  lib,
  pkgs,
  pkgs-prev,
  ...
}:

{
  home.packages =
    (with pkgs-prev.llvmPackages_21; [
      clang-tools
      clang
    ])
    ++ (with pkgs; [
      (lib.hiPrio gcc) # high priority used because both clang and gcc share the /bin/c++ binary
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

      bear
      compiledb
    ]);
}
