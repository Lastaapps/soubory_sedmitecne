return {
  -- --- NVim -----------------------------------------------------------------
  -- Adds coroutines
  { "nvim-lua/plenary.nvim" },

  -- --- Productivity tools ---------------------------------------------------
  -- Disables some features for large files
  {
    "LunarVim/bigfile.nvim",
    event = "BufReadPre",
    opts = {
      filesize = 2,      -- size of the file in MiB, the plugin round file sizes to the closest MiB
      pattern = { "*" }, -- autocmd pattern or function see <### Overriding the detection of big files>
      features = {       -- features to disable
        "indent_blankline",
        "illuminate",
        "lsp",
        "treesitter",
        "syntax",
        "matchparen",
        "vimopts",
        "filetype",
      },
    },
  },

  -- NVim autopairs
  -- Closes brackets on the Enter key press
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter"
  },

  -- https://github.com/folke/todo-comments.nvim
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {}
  },

  -- File manager used by editing a buffer
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      win_options = {
        spell = true,
      },
      view_options = {
        show_hidden = true,
      },
    },
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    -- cmd is not enough when `vim .` is performed
    lazy = false,
    -- cmd = { "Oil" }, -- idk, I'll lazy load you anyway
  },

  -- Markdown preview
  -- Run :MarkdownPreview
  -- {'iamcco/markdown-preview.nvim', build = 'cd app && yarn install', cmd = 'MarkdownPreview'},

  -- File-type based indentation
  { 'tpope/vim-sleuth',     event = "VeryLazy" },

  -- AutoMatching
  -- g% [% ]% z%, i% a%
  {
    'andymass/vim-matchup',
    event = "InsertEnter",
    init = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end
  },


  -- --- 'Exotic' languages ----------------------------------------------------
  -- SQL
  {
    'nanotee/sqls.nvim',
    ft = { 'sql', 'mysql', 'plsql', 'sqlite' },
  },

  -- English
  {
    'barreiroleo/ltex_extra.nvim',
    event = "VeryLazy",
  },
}
