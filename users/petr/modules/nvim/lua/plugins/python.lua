-- Python workspace setup
return {
    -- Enables switching f strings
    {
        'roobert/f-string-toggle.nvim',
        ft     = "python",
        config = function()
            require("f-string-toggle").setup({
                key_binding = "<leader>f",
                key_binding_desc = "Toggle f-string"
            })
        end,
    },
}
