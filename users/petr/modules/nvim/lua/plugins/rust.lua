-- Rust
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
