-- Treesitter
-- syntax tree analysis

local isNixOS = true;

local my_tree_sitter = {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  opts = {
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
    -- Folding setup
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufAdd', 'BufNew', 'BufNewFile', 'BufWinEnter' }, {
      group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
      callback = function()
        -- https://neovim.io/doc/user/usr_28.html#usr_28.txt
        vim.opt.foldmethod     = 'expr'
        vim.opt.foldexpr       = 'v:lua.vim.treesitter.foldexpr()'
        vim.opt.foldlevelstart = 2
        vim.opt.foldnestmax    = 5
        vim.opt.foldminlines   = 3
      end
    })
  end,
}

-- Configure NixOS
if isNixOS then
  my_tree_sitter.opts.auto_install = false
  my_tree_sitter.opts.ensure_installed = {}
else
  my_tree_sitter.build = ':TSUpdate'
  my_tree_sitter.opts.auto_install = true
  my_tree_sitter.opts.ensure_installed = "all"
end

return {
  my_tree_sitter,
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "VeryLazy",
  }
}
