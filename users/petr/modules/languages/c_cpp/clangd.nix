{config, ...}:

{
  home.file = {
    "${config.xdg.configHome}/clangd/config.yaml".source = ./clangd_config.yaml;
  };
}
