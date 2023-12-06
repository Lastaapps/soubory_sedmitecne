-- Taken from https://github.com/wbthomason/packer.nvim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'


  -- --- NVim -----------------------------------------------------------------
  -- Adds coroutines
  use "nvim-lua/plenary.nvim"
  --
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

  -- VimSpector
  -- Debugger inside vim
  -- use 'puremourning/vimspector'


  -- Theme
  use 'jacoborus/tender.vim'


  -- --- NerdTree -------------------------------------------------------------
  use 'preservim/nerdtree'
  use 'Xuyuanp/nerdtree-git-plugin'


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
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'

  -- Autocomplete NVim lua api
  use 'hrsh7th/cmp-nvim-lua'
  -- Add dictionary support
  use 'uga-rosa/cmp-dictionary'
  -- Add spelling support
  use 'f3fora/cmp-spell'




  -- --- Languages ------------------------------------------------------------
  -- Kotlin - better Kotlin support
  use 'udalov/kotlin-vim'

  -- Rust tools
  use 'simrat39/rust-tools.nvim'
  use {
    'saecki/crates.nvim',
    tag = 'v0.3.0',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
        require('crates').setup()
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
