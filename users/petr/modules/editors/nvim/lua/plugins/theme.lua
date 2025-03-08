local load_all_themes = false

return {
    -- Better notifications
    {
        'rcarriga/nvim-notify',
        lazy = false
    },

    -- Transparent background
    {
        "xiyaowong/transparent.nvim",
        lazy = false,
        priority = 2000,
    },

    -- Themes
    {
        "catppuccin/nvim",
        name = "catppuccin-nvim",
        lazy = not load_all_themes,
        priority = 1000,
    },
    {
        "scottmckendry/cyberdream.nvim",
        lazy = not load_all_themes,
        priority = 1000,
        opts = {
            transparent = true,
            italic_comments = true,
        },
    },
    {
        "iagorrr/noctis-high-contrast.nvim",
        lazy = not load_all_themes,
        priority = 1000,
    },
    {
        "navarasu/onedark.nvim",
        lazy = not load_all_themes,
        priority = 1000,
        opts = {
            -- style = "darker",
            style = "warmer",
            transparent = true,
        }
    },
    {
        'jacoborus/tender.vim',
        lazy = not load_all_themes and false,
        priority = 1000,
    },
}
