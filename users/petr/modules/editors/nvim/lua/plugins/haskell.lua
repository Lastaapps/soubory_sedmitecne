-- https://github.com/MrcJkb/haskell-tools.nvim

return {
    {
        'mrcjkb/haskell-tools.nvim',
        -- I still use lazy loading so this plugin is loaded after the nvim-cmp and lspconfig
        -- lazy = false, -- This plugin is already lazy
        ft = { "haskell", "cabal" },
        -- LSP was not working properly (almost not at all)
        enabled = false,
    }
}
