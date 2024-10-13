{pkgs, ...}:

{
  home.packages = with pkgs; [
    # Language server
    glsl_analyzer
  ];
}
