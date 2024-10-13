{pkgs, ...}:

{
  home.packages = with pkgs; [
    metals
    sbt
    coursier
    jdk21
  ];
}
