-- Treesitter
-- syntax tree analysis

local isNixOS = true;

if isNixOS then
    --
-- NixOS with lazy.nvim
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      auto_install = false,
      ensure_installed = {},
    },
    config = function()
    end
  },
}

else

-- Usuall config
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ':TSUpdate',
    opts = {
      ensure_installed = "all",
      auto_install = true,
      highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
      },
      ident = { enable = true },
      rainbow = {
          enable = true,
          extended_mode = true,
          max_file_lines = nil,
      },
      matchup = {
          enable = true,
      },
      incremental_selection = {
          enable = true,
          keymaps = {
              -- set to `false` to disable one of the mappings
              init_selection = "gnn",
              scope_incremental = "grc",
              node_incremental = "grn",
              node_decremental = "grm",
          },
      },
    },
    config = function()
    end
  }
} end
