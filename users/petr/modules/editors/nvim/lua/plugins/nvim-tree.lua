-- Inspired by https://github.com/josean-dev/dev-environment-files/blob/main/.config/nvim/lua/josean/plugins/nvim-tree.lua
return {
    "nvim-tree/nvim-tree.lua",
    event = "VeryLazy",
    config = function()
        local nvimtree = require("nvim-tree")

        -- Disable default netrw
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        nvimtree.setup({
            view = {
                width = 50,
                relativenumber = true,
            },
            -- disable window_picker for
            -- explorer to work well with
            -- window splits
            actions = {
                open_file = {
                    window_picker = {
                        enable = false,
                    },
                },
            },
            -- filters = {
            --     custom = { "" },
            -- },
            git = {
                ignore = false,
            },
        })

        local keymap = vim.keymap
        keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
        keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>",
            { desc = "Toggle file explorer on current file" })
        keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
        keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })
    end,
}
