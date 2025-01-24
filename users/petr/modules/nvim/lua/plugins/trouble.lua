-- https://github.com/folke/trouble.nvim
-- Custom panels and diagnostic views
return {
    "folke/trouble.nvim",
    -- event = "VeryLazy",
    cmd = "Trouble",
    keys = {
        {
            "<leader>td",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "[D]iagnostics (Trouble)",
        },
        {
            "<leader>tb",
            "<cmd>Trouble diagnostics_buffer toggle<cr>",
            desc = "[B]uffer Diagnostics (Trouble)",
        },
        {
            "<leader>ts",
            "<cmd>Trouble symbols toggle focus=false<cr>",
            desc = "[S]ymbols (Trouble)",
        },
        {
            "<leader>tl",
            "<cmd>Trouble lsp toggle focus=false<cr>",
            desc = "[L]SP Definitions / references / ... (Trouble)",
        },
        {
            "<leader>tf",
            "<cmd>Trouble telescope_files toggle<cr>",
            desc = "[F]iles from Telescope (Trouble)",
        },
    },
    opts = {
        modes = {
            -- Shows diagnostics provided by LSP
            -- diagnostics = { auto_open = true },
            diagnostics_buffer = {
                desc = "Buffer diagnostics",
                mode = "diagnostics", -- inherit from diagnostics mode
                filter = { buf = 0 }, -- filter diagnostics to the current buffer
                preview = {
                    type = "split",
                    relative = "win",
                    position = "right",
                    size = 0.42,
                },
            },

            -- Shows LSP references of the provided symbol
            lsp = {
                mode = "lsp",
                focus = true,
                preview = {
                    type = "split",
                    relative = "win",
                    position = "right",
                    size = 0.42,
                },
            },

            -- Shows LSP symbols if the whole file like functions and classes
            symbols = {
                desc = "document symbols",
                mode = "lsp_document_symbols",
                -- auto_open = true,
                focus = false,
                win = { position = "right" },
            },

            telescope_files = {
                mode = "telescope_files",
                focus = true,
                open_no_results = true,
                win = { position = "right", size = 0.20 },
            }
        }
    },
}
