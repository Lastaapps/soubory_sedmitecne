-- set in the NixOS config, has to be set before loading lazy.nvim
-- vim.g.mapleader = ' '
-- vim.g.maplocalleader = ' '

-- Numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Tabs and indents
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Indents
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Searching
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

-- Wrapping
vim.opt.wrap = false

-- Minimum number of screen lines to keep above and below the cursor
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Enforces unit line breaks
vim.opt.fileformat = 'unix'

-- Spelling
vim.opt.spell = true
vim.opt.spelllang = { 'en_us', 'cs' }

-- Enables loading of external scrips (.nvim.lua), see :help exrc
vim.opt.exrc = true

-- Default folding while tree sitter is not enabled
vim.opt.foldmethod = 'indent'
vim.opt.foldcolumn = 'auto:9'

-- Prevents autocompletion items to be automatically selected
vim.opt.completeopt = 'menu,menuone,preview,noinsert' -- ,noselect

-- Last column and spaces highlight
vim.opt.colorcolumn = '80'
vim.api.nvim_exec2([[
highlight ColorColumn ctermbg=blue guibg=lightgrey
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
]], {})

vim.diagnostic.config({ virtual_text = true })
