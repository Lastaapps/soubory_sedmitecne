return {
    {
        'neovim/nvim-lspconfig',
    },
    {
        'hrsh7th/nvim-cmp',
        event = "InsertEnter",
        dependencies = {
            -- Communication with nvim lsp server
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-path',
            -- 'hrsh7th/cmp-omni',

            -- Autocomplete NVim lua api
            -- 'hrsh7th/cmp-nvim-lua',

            -- Add spelling support
            'f3fora/cmp-spell',

            -- Snippets, proper config is in luasnip.lua
            'saadparwaiz1/cmp_luasnip',
        },
        config = function()
            local cmp = require('cmp')
        end,
    },
}
