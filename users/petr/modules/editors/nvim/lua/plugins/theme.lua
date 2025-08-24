local load_all_themes = false

return {
    -- https://github.com/j-hui/fidget.nvim
    -- Provides status updates in the bottom right corner
    {
        "j-hui/fidget.nvim",
        event = "VeryLazy",
    },

    -- Transparent background
    {
        "xiyaowong/transparent.nvim",
        lazy = false,
        priority = 2000,
    },

    -- Customizable bottom bar
    {
        'nvim-lualine/lualine.nvim',
        event = "VeryLazy",
        -- dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            -- Themes: https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md
            options = {
                -- auto nightfly onedark nord
                theme = 'onedark',
            },
        },
    },
    -- Last line with file info + other plugins integration
    {
        'vim-airline/vim-airline',
        enabled = false,
        lazy = false,
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
