-- GoLang workspace setup
return {
    {
        'ray-x/go.nvim',
        ft = 'go',
        config = function()
            require('go').setup()
        end
    },
    {
        'leoluz/nvim-dap-go',
        ft = 'go',
        config = function()
            require('dap-go').setup()
        end
    },
}
