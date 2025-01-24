-- FZF
-- CTRL-T / CTRL-X / CTRL-V - tab, hsplit, vsplit
return {
    "junegunn/fzf.vim",
    event = "VeryLazy",
    config = function()
        local opts = { noremap = true, silent = true }
        vim.api.nvim_set_keymap("n", "<A-f>f", ":Files<CR>", opts)
        vim.api.nvim_set_keymap("n", "<A-f>c", ":RG<CR>", opts)
        vim.api.nvim_set_keymap("n", "<A-f>b", ":Buffers<CR>", opts)
        vim.api.nvim_set_keymap("n", "<A-f>m", ":Maps<CR>", opts)
        vim.api.nvim_set_keymap("n", "<A-f>t", ":Types<CR>", opts)
    end
}
