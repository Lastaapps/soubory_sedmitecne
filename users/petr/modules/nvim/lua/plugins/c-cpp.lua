-- C & CPP workspace setup

-- Loads debugger
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*.c", "*.h", "*.cpp", "*.hpp" },
    callback = function(ev)
        require("dap")
    end
})

return {
    {
        'p00f/clangd_extensions.nvim',
        ft = { 'c', 'cpp' },
        config = function()
            require('clangd_extensions').setup {}
        end,
    },
}
