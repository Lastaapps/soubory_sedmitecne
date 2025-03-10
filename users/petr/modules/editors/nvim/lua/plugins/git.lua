return {
    -- Shows sign markers on sides
    -- https://github.com/lewis6991/gitsigns.nvim
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        opts = {},
    },

    -- Git integration
    -- :G git command, e.g. :G status
    {
        'tpope/vim-fugitive',
        -- event = "VeryLazy",
        cmd = { "G", "Git" },
    },
}
