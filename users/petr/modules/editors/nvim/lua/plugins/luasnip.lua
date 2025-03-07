return {
    -- Autocompletion integration
    {
        'saadparwaiz1/cmp_luasnip',
        dependencies = { "L3MON4D3/LuaSnip" },
    },
    -- Snipping engine (required)
    {
        'L3MON4D3/LuaSnip',
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
            local ls = require('luasnip')

            -- LuaSnip shortcuts
            vim.keymap.set({ "i" }, "<C-K>", function() ls.expand() end, { silent = true })
            vim.keymap.set({ "i", "s" }, "<C-L>", function() ls.jump(1) end, { silent = true })
            vim.keymap.set({ "i", "s" }, "<C-J>", function() ls.jump(-1) end, { silent = true })

            vim.keymap.set({ "i", "s" }, "<C-E>", function()
                if ls.choice_active() then
                    ls.change_choice(1)
                end
            end, { silent = true })
        end
    },
    { 'rafamadriz/friendly-snippets' },

    -- TeX, LaTeX
    -- As I remember this one is worse
    -- {
    --     'evesdropper/luasnip-latex-snippets.nvim',
    --     ft = { "tex", "latex", "bib" }
    -- },
    {
        "iurimateus/luasnip-latex-snippets.nvim",
        ft = { "tex", "latex", "bib" },
        dependencies = { "L3MON4D3/LuaSnip", "nvim-treesitter/nvim-treesitter" },
        config = function()
            require('luasnip-latex-snippets').setup({ use_treesitter = true })
            require("luasnip").config.setup { enable_autosnippets = true }
        end,
    },
    {
        "mrcjkb/haskell-snippets.nvim",
        ft = { "haskell" },
        dependencies = { "L3MON4D3/LuaSnip" },
        config = function()
            local ls = require("luasnip")
            local haskell_snippets = require('haskell-snippets').all
            ls.add_snippets('haskell', haskell_snippets, { key = 'haskell' })
        end,
    }
}
