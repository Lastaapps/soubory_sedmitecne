-- https://github.com/MrcJkb/haskell-tools.nvim

return {
    {
        'mrcjkb/haskell-tools.nvim',
        ft = { "haskell", "cabal" },
        version = '^4',
        -- I still use lazy loading so this plugin is loaded after the nvim-cmp and lspconfig
        -- lazy = false, -- This plugin is already lazy
    }
}
