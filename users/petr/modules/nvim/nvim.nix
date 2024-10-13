{config, pkgs, lib, ...}:

{
  # lazy.nvim setup taken from:
  # https://github.com/LazyVim/LazyVim/discussions/1972
  # https://nixalted.com/
  # https://github.com/KFearsoff/NixOS-config/blob/90fa0fb9a361c1dcf82a5ac6292989e3e113ed93/nixosModules/neovim/default.nix


  # TODO enable lazy loading
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    # withNodeJs = true;

    # nix-env -f '<nixpkgs>' -qaP -A vimPlugins | cut -d ' ' -f1 | cut -d '.' -f2 | sort | less
    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];

    extraLuaPackages = ps: with ps; [
      # Used by the image-nvim plugin
      magick
    ];
    extraPackages = with pkgs; [
      # Used by the image-nvim plugin
      ueberzug
      # ueberzugpp
      imagemagick
      gcc # needed for nvim-treesitter

      # # LazyVim defaults
      # stylua
      # shfmt

      # # Markdown extra
      # nodePackages.markdownlint-cli
      # marksman

      # # Docker extra
      # nodePackages.dockerfile-language-server-nodejs
      # hadolint
      # docker-compose-language-service

      # # JSON and YAML extras
      # nodePackages.yaml-language-server

      # # Custom
      # editorconfig-checker
      # shellcheck
    ];
  
    extraLuaConfig =
    let
      plugins = with pkgs.vimPlugins; [
        which-key-nvim

        plenary-nvim
        # vim-obcession
        transparent-nvim
        image-nvim

        # treesitter
        nvim-treesitter-context
        nvim-ts-autotag
        nvim-treesitter-textobjects
        nvim-treesitter.withAllGrammars

        fzf-lua
        presence-nvim
        nvim-notify
        kommentary
        nvim-autopairs

        vim-fugitive
        vim-sleuth
        vim-airline
        vim-matchup
        tender-vim
        vim-tmux-navigator
        zoxide-vim

        nvim-lspconfig
        nvim-cmp
        cmp-nvim-lsp
        cmp-buffer
        cmp-cmdline
        cmp-path
        cmp-omni

        luasnip
        cmp_luasnip
        neodev-nvim
        cmp-spell
        codeium-nvim

        telescope-nvim
        telescope-fzf-native-nvim
        # harpoon

        # TODO
        # luasnip-latex-snippets-nvim
        nvim-dap
        nvim-nio
        nvim-dap-ui
        nvim-dap-virtual-text
        nvim-dap-python

        kotlin-vim
        crates-nvim
        rustaceanvim
        go-nvim
        nvim-dap-go
        clangd_extensions-nvim
        # TODO
        # f-string-toggle-nvim
        # sqls-nvim
        nvim-metals
        ltex_extra-nvim

        # As the name differs an lazy cannot find the plugin
        # in has to be renamed
        { name = "LuaSnip"; path = luasnip; }
      ];
      mkEntryFromDrv = drv:
        if lib.isDerivation drv then
          { name = "${lib.getName drv}"; path = drv; }
        else
          drv;
      lazyPath = pkgs.linkFarm "lazy-plugins" (builtins.map mkEntryFromDrv plugins);
    in ''
      vim.g.mapleader = "." -- Need to set leader before lazy for correct keybindings
      require("lazy").setup({
        spec = {
          -- { "LazyVim/LazyVim", import = "lazyvim.plugins" },
          -- -- import any extras modules here
          -- { import = "lazyvim.plugins.extras.dap.core" },
          -- { import = "lazyvim.plugins.extras.dap.nlua" },
          -- { import = "lazyvim.plugins.extras.ui.edgy" },
          -- { import = "lazyvim.plugins.extras.editor.aerial" },
          -- { import = "lazyvim.plugins.extras.editor.leap" },
          -- { import = "lazyvim.plugins.extras.editor.navic" },
          -- { import = "lazyvim.plugins.extras.lang.docker" },
          -- { import = "lazyvim.plugins.extras.lang.json" },
          -- { import = "lazyvim.plugins.extras.lang.markdown" },
          -- { import = "lazyvim.plugins.extras.lang.rust" },
          -- { import = "lazyvim.plugins.extras.lang.yaml" },
          -- { import = "lazyvim.plugins.extras.test.core" },
          -- { import = "lazyvim.plugins.extras.ui.mini-animate" },
          -- import/override with your plugins
          { import = "plugins" },
        },
        defaults = {
          -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
          -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.




          -- TODO
          lazy = false,




          -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
          -- have outdated releases, which may break your Neovim install.
          version = false, -- always use the latest git commit
          -- version = "*", -- try installing the latest stable version for plugins that support semver
        },
        performance = {
          reset_packpath = false,
          rtp = { reset = false, }
        },
        dev = {
          path = "${lazyPath}",
          patterns = {""}, -- Specify that all of our plugins will use the dev dir. Empty string is a wildcard!
        },
        install = {
          -- Safeguard in case we forget to install a plugin with Nix
          missing = false,
        },
      })

      require("mynvim")
    '';
  };

  xdg.configFile."nvim/lua" = {
    recursive = true;
    source = ./lua;
  };
  # TODO handle properly
  xdg.configFile."nvim/spell" = {
    recursive = true;
    source = ./spell;
  };
}

