-- C & CPP workspace setup
return {
    {
        'p00f/clangd_extensions.nvim',
        ft = { 'c', 'cpp' },
        config = function()
            require('clangd_extensions').setup {}
        end,
    },
}
