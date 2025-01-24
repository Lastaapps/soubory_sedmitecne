-- https://github.com/monkoose/neocodeium
-- AI assistant, but maintained and feature full
return {
    "monkoose/neocodeium",
    event = "VeryLazy",
    config = function()
        local cmp = require("cmp")
        local neocodeium = require("neocodeium")

        neocodeium.setup({
            filter = function()
                return not cmp.visible()
            end,
        })

        vim.keymap.set("i", "<A-f>", neocodeium.accept)
        vim.keymap.set("i", "<A-w>", neocodeium.accept_word)
        vim.keymap.set("i", "<A-a>", neocodeium.accept_line)
        vim.keymap.set("i", "<A-e>", function()
            neocodeium.cycle_or_complete()
        end)
        vim.keymap.set("i", "<A-r>", function()
            neocodeium.cycle_or_complete(-1)
        end)
        vim.keymap.set("i", "<A-c>", neocodeium.clear)
    end,
}
