-- Treesitter
-- syntax tree analysis

local isNixOS = true;

local my_tree_sitter = {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
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
    opts = {
      enable = true,           -- Enable this plugin (Can be enabled/disabled later via commands)
      max_lines = 0,           -- How many lines the window should span. Values <= 0 mean no limit.
      min_window_height = 0,   -- Minimum editor window height to enable context. Values <= 0 mean no limit.
      line_numbers = true,
      multiline_threshold = 3, -- Maximum number of lines to show for a single context
      trim_scope = "outer",    -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
      mode = "cursor",         -- Line used to calculate context. Choices: 'cursor', 'topline'
      -- Separator between context and content. Should be a single character string, like '-'.
      -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
      separator = nil,
      zindex = 20,     -- The Z-index of the context window
      on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    config = function()
      -- Inspired by https://github.com/josean-dev/dev-environment-files/blob/main/.config/nvim/lua/josean/plugins/nvim-treesitter-text-objects.lua
      require("nvim-treesitter.configs").setup({
        textobjects = {
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
              ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
              ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
              ["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
              ["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

              ["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
              ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

              ["ai"] = { query = "@conditional.outer", desc = "Select conditional (If) (outer)" },
              ["ii"] = { query = "@conditional.inner", desc = "Select conditional (If) (inner)" },

              ["al"] = { query = "@loop.outer", desc = "Select Loop (outer)" },
              ["il"] = { query = "@loop.inner", desc = "Select Loop (inner)" },

              ["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
              ["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

              ["am"] = { query = "@function.outer", desc = "Select outer part of a method/function definition" },
              ["im"] = { query = "@function.inner", desc = "Select inner part of a method/function definition" },

              ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>n="] = { query = "@assignment.outer", desc = "Swap assignment with next" },
              ["<leader>na"] = { query = "@parameter.inner", desc = "Swap parameters/argument with next" },
              ["<leader>nm"] = { query = "@function.outer", desc = "Swap function with next" },
            },
            swap_previous = {
              ["<leader>p="] = { query = "@assignment.outer", desc = "Swap assignment with prev" },
              ["<leader>pa"] = { query = "@parameter.inner", desc = "Swap parameters/argument with prev" },
              ["<leader>p:"] = { query = "@property.outer", desc = "Swap object property with prev" },
              ["<leader>pm"] = { query = "@function.outer", desc = "Swap function with previous" },
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]f"] = { query = "@call.outer", desc = "Next function call start" },
              ["]m"] = { query = "@function.outer", desc = "Next method/function def start" },
              ["]c"] = { query = "@class.outer", desc = "Next class start" },
              ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
              ["]l"] = { query = "@loop.outer", desc = "Next loop start" },
            },
            goto_next_end = {
              ["]F"] = { query = "@call.outer", desc = "Next function call end" },
              ["]M"] = { query = "@function.outer", desc = "Next method/function def end" },
              ["]C"] = { query = "@class.outer", desc = "Next class end" },
              ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
              ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
            },
            goto_previous_start = {
              ["[f"] = { query = "@call.outer", desc = "Prev function call start" },
              ["[m"] = { query = "@function.outer", desc = "Prev method/function def start" },
              ["[c"] = { query = "@class.outer", desc = "Prev class start" },
              ["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
              ["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
            },
            goto_previous_end = {
              ["[F"] = { query = "@call.outer", desc = "Prev function call end" },
              ["[M"] = { query = "@function.outer", desc = "Prev method/function def end" },
              ["[C"] = { query = "@class.outer", desc = "Prev class end" },
              ["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
              ["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
            },
          },
        },
      })

      local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

      -- Repeat movement with ; and ,
      -- ensure ; goes forward and , goes backward regardless of the last direction
      vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
      vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

      -- vim way: ; goes to the direction you were moving.
      -- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
      -- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

      -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
      vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
      vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
      vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
      vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
    end,
  },
}
