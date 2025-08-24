-- Checks for bad habits regarding Vim motions
-- https://github.com/m4xshen/hardtime.nvim
return {
    "m4xshen/hardtime.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "MunifTanjim/nui.nvim", "j-hui/fidget.nvim" },
    opts = {
        callback = function(text)
            local fidget = require("fidget")
            fidget.notify(
                text,
                vim.log.levels.WARN,
                { annote = "Hardtime", timeout = 2000 }
            )
        end,
    },
}
