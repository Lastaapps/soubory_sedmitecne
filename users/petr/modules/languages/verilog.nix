{pkgs, ...}:

{
  home.packages = with pkgs; [
    # Language server
    svls

    verilog
  ];
}
