return {
  -- --- NVim -----------------------------------------------------------------
  -- Adds coroutines
  { "nvim-lua/plenary.nvim" },

  -- Saves session state
  -- TODO { "tpope/vim-obsession" },
  -- Transparent background
  { "xiyaowong/transparent.nvim" },

  -- --- Utils ----------------------------------------------------------------

  -- FZF
  -- CTRL-T / CTRL-X / CTRL-V - tab, hsplit, vsplit
  { "junegunn/fzf.vim" },

  -- Better notifications
  { 'rcarriga/nvim-notify' },

  -- --- Productivity tools ---------------------------------------------------

  -- NVim autopairs
  -- Closes brackets on the Enter key press
  { "windwp/nvim-autopairs" },

  -- Markdown preview
  -- Run :MarkdownPreview
  -- {'iamcco/markdown-preview.nvim', build = 'cd app && yarn install', cmd = 'MarkdownPreview'},

  -- Git integration
  -- :G git command, e.g. :G status
  { 'tpope/vim-fugitive' },

  -- File-type based indentation
  { 'tpope/vim-sleuth' },

  -- AutoMatching
  -- g% [% ]% z%, i% a%
  {
    'andymass/vim-matchup',
    init = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end
  },


  -- Theme
  { 'jacoborus/tender.vim' },

  -- Snippets
  -- TODO fix and move to plugins/luasnip.lua
  -- {
  --   "iurimateus/luasnip-latex-snippets.nvim",
  --   dependencies = { "L3MON4D3/LuaSnip", "nvim-treesitter/nvim-treesitter" },
  --   config = function()
  --     require('luasnip-latex-snippets').setup({ use_treesitter = true })
  --     require("luasnip").config.setup { enable_autosnippets = true }
  --   end,
  -- },


  -- Debugging
  -- NVim debugger
  { 'mfussenegger/nvim-dap' },
  { 'nvim-neotest/nvim-nio' },
  { 'rcarriga/nvim-dap-ui' },
  { 'theHamsta/nvim-dap-virtual-text' },
  { 'mfussenegger/nvim-dap-python' },




  -- --- Languages ------------------------------------------------------------
  -- Kotlin - better Kotlin support
  { 'udalov/kotlin-vim' },

  -- Rust
  {
    'saecki/crates.nvim',
    version = 'stable',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('crates').setup()
    end,
  },
  {
    'mrcjkb/rustaceanvim',
    ft = { 'rust' },
  },

  -- GoLang
  { 'ray-x/go.nvim' },
  { 'leoluz/nvim-dap-go' },

  -- clangd extensions
  { 'p00f/clangd_extensions.nvim' },

  -- Python
  -- TODO
  -- {
  --   'roobert/f-string-toggle.nvim',
  --   config = function()
  --     require("f-string-toggle").setup({
  --       key_binding = "<leader>f",
  --       key_binding_desc = "Toggle f-string"
  --     })
  --   end,
  -- },

  -- SQL
  { 'nanotee/sqls.nvim' },

  -- Scala

  -- English
  { 'barreiroleo/ltex_extra.nvim' },
}
