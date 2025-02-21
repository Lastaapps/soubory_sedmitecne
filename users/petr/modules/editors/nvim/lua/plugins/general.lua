return {
  -- --- NVim -----------------------------------------------------------------
  -- Adds coroutines
  { "nvim-lua/plenary.nvim" },

  -- Theme
  {
    'jacoborus/tender.vim',
    lazy = false
  },

  -- Transparent background
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
  },

  -- Better notifications
  {
    'rcarriga/nvim-notify',
    lazy = false
  },

  -- --- Productivity tools ---------------------------------------------------

  -- NVim autopairs
  -- Closes brackets on the Enter key press
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter"
  },

  -- Markdown preview
  -- Run :MarkdownPreview
  -- {'iamcco/markdown-preview.nvim', build = 'cd app && yarn install', cmd = 'MarkdownPreview'},

  -- Git integration
  -- :G git command, e.g. :G status
  { 'tpope/vim-fugitive',   event = "VeryLazy" },

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
