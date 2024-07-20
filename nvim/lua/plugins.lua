-- Taken from https://github.com/wbthomason/packer.nvim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'


  -- --- NVim -----------------------------------------------------------------
  -- Adds coroutines
  use "nvim-lua/plenary.nvim"

  -- Saves session state
  use "tpope/vim-obsession"
  -- Transparent background
  use "xiyaowong/transparent.nvim"

  -- --- Utils ----------------------------------------------------------------
  -- Treesitter
  -- syntax tree analysis
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- FZF
  -- CTRL-T / CTRL-X / CTRL-V - tab, hsplit, vsplit
  use "junegunn/fzf.vim"

  -- Discord Ritch Presence
  use 'andweeb/presence.nvim'

  -- Better notifications
  use 'rcarriga/nvim-notify'

  -- --- Productivity tools ---------------------------------------------------
  -- Kommentary
  -- Used for comments
  -- github.com/b3nj5m1n/kommentary
  -- gcc - Toggle line
  -- gc  - Toggle selection/motion
  use 'b3nj5m1n/kommentary'
  require('kommentary.config').configure_language("default", {
    prefer_single_line_comments = true,
  })

  -- NVim autopairs
  -- Closes brackets on the Enter key press
  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }

  -- Markdown preview
  -- Run :MarkdownPreview
  -- use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}

  -- Git integration
  -- :G git command, e.g. :G status
  use 'tpope/vim-fugitive'

  -- File-type based indentation
  use 'tpope/vim-sleuth'

  -- Last line with file info + other plugins integration
  use 'vim-airline/vim-airline'

  -- AutoMatching
  -- g% [% ]% z%, i% a%
  use {
    'andymass/vim-matchup',
    setup = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end
  }


  -- Theme
  use 'jacoborus/tender.vim'


  -- --- NerdTree -------------------------------------------------------------
  use 'preservim/nerdtree'
  use 'Xuyuanp/nerdtree-git-plugin'


  -- --- Tmux integration -----------------------------------------------------
  use 'christoomey/vim-tmux-navigator'

  -- --- Zoxide integration ---------------------------------------------------
  use 'nanotee/zoxide.vim'


  -- --- IDE ------------------------------------------------------------------
  use 'neovim/nvim-lspconfig'

  use 'hrsh7th/nvim-cmp'
  -- Communication with nvim lsp server
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-path'
  -- use 'hrsh7th/cmp-omni'

  -- Snipping engine (required)
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

  -- Autocomplete NVim lua api
  use 'folke/neodev.nvim'
  -- use 'hrsh7th/cmp-nvim-lua'

  -- Add spelling support
  use 'f3fora/cmp-spell'

  -- AI
  use {
    "Exafunction/codeium.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup({
      })
    end
  }

  -- Snippets
  use {
  "iurimateus/luasnip-latex-snippets.nvim",
  requires = { "L3MON4D3/LuaSnip", "nvim-treesitter/nvim-treesitter" },
  config = function()
    require('luasnip-latex-snippets').setup({ use_treesitter = true })
    require("luasnip").config.setup { enable_autosnippets = true }
  end,
}


  -- Debugging
  -- NVim debugger
  use 'mfussenegger/nvim-dap'
  use 'nvim-neotest/nvim-nio'
  use 'rcarriga/nvim-dap-ui'
  use 'theHamsta/nvim-dap-virtual-text'

  use 'mfussenegger/nvim-dap-python'




  -- --- Languages ------------------------------------------------------------
  -- Kotlin - better Kotlin support
  use 'udalov/kotlin-vim'

  -- Rust
  use {
    'saecki/crates.nvim',
    tag = 'stable',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('crates').setup()
    end,
  }
  use {
    'mrcjkb/rustaceanvim',
    ft = { 'rust' },
  }

  -- GoLang
  use 'ray-x/go.nvim'
  use 'leoluz/nvim-dap-go'

  -- clangd extensions
  use 'p00f/clangd_extensions.nvim'

  -- Python
  use {
    'roobert/f-string-toggle.nvim',
    config = function()
      require("f-string-toggle").setup({
        key_binding = "<leader>f",
        key_binding_desc = "Toggle f-string"
      })
    end,
  }



  -- --- For the future use ---------------------------------------------------
  -- GalaxyLine
  -- advanced status bar
  -- https://github.com/glepnir/galaxyline.nvim
  -- use({
  --   'glepnir/galaxyline.nvim',
  --   branch = 'main',
  --   config = function()
  --     require('my_statusline')
  --   end,
  --   requires = { 'nvim-tree/nvim-web-devicons', opt = true },
  -- })

  -- Firenvim
  -- Browser extension for nvim integration
  -- github.com/glacambre/firenvim
  -- use {
  --   'glacambre/firenvim',
  --   run = function() vim.fn['firenvim#install'](0) end
  -- }
end)
