-- Rust

-- generate tags
-- https://github.com/dan-t/rusty-tags
vim.api.nvim_exec2([[
    autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi
    autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!
]], {})

-- Loads debugger
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*.rs" },
    callback = function(ev)
        require("dap")
    end
})

return {
    {
        'saecki/crates.nvim',
        ft = { 'rust', 'toml' },
        version = 'stable',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('crates').setup({})
        end,
    },
    {
        'mrcjkb/rustaceanvim',
        ft = { 'rust' },
    },
}
