-- Treesitter
-- syntax tree analysis

local isNixOS = true;

local my_tree_sitter = {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  opts = {
    autopairs = { enable = true },
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
  config = function(opts)
    require("nvim-treesitter.configs").setup(opts)

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
    opts = {
      enable = true,            -- Enable this plugin (Can be enabled/disabled later via commands)
      max_lines = 0,            -- How many lines the window should span. Values <= 0 mean no limit.
      min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
      line_numbers = true,
      multiline_threshold = 20, -- Maximum number of lines to show for a single context
      trim_scope = "outer",     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
      mode = "cursor",          -- Line used to calculate context. Choices: 'cursor', 'topline'
      -- Separator between context and content. Should be a single character string, like '-'.
      -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
      separator = nil,
      zindex = 20,     -- The Z-index of the context window
      on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
    },
  }
}
