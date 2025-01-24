-- https://github.com/stevearc/conform.nvim
-- Promises better and more stable formatting
-- that prevents formatters from just replacing the whole buffer.

return {
    "stevearc/conform.nvim",
    event = "VeryLazy",
    init = function()
        -- Replace global formatter
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
    opts = {
        format_on_save = {
            -- These options will be passed to conform.format()
            timeout_ms = 500,
        },

        default_format_opts = {
            lsp_format = "fallback",
        },

        -- Map of filetype to formatters
        formatters_by_ft = {
            -- Conform will run multiple formatters sequentially
            go = { "goimports", "gofmt" },

            rust = { "rustfmt" },

            python = function(bufnr)
                if require("conform").get_formatter_info("ruff_format", bufnr).available then
                    return { "ruff_format" }
                else
                    return { "isort", "black" }
                end
            end,

            -- Use the "*" filetype to run formatters on all filetypes.
            -- ["*"] = { "codespell" },
            -- Use the "_" filetype to run formatters on filetypes that don't
            -- have other formatters configured.
            -- ["_"] = { "trim_whitespace" },
        },
    },
}
