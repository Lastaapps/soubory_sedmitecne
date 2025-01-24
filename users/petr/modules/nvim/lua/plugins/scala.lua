return {
    "scalameta/nvim-metals",
    dependencies = {
        {
            'nvim-lua/plenary.nvim',
            {
                "j-hui/fidget.nvim",
                opts = {},
            }
        },
        { 'mfussenegger/nvim-dap' }
    },
    ft = { "scala", "sbt", "java" },
    opts = function()
        local metals_config = require("metals").bare_config()

        metals_config.settings = {
            showImplicitArguments = true,
            excludedPackages = {},
        }

        -- I *highly* recommend setting statusBarProvider to either "off" or "on"
        -- "off" will enable LSP progress notifications by Metals and you'll need
        -- to ensure you have a plugin like fidget.nvim installed to handle them.
        -- "on" will enable the custom Metals status extension and you *have* to have
        -- a have settings to capture this in your statusline or else you'll not see
        -- any messages from metals. There is more info in the help docs about this
        metals_config.init_options.statusBarProvider = "off"

        metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

        metals_config.on_attach = function(client, bufnr)
            local metals = require("metals")
            metals.setup_dap()

            vim.keymap.set("n", "<leader>ws", function()
                metals.hover_worksheet()
            end)

            -- Telescope integration
            vim.keymap.set("n", "<leader>fs", function()
                require("telescope").extensions.metals.commands()
            end)
        end

        return metals_config
    end,
    config = function(self, metals_config)
        local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
        vim.api.nvim_create_autocmd("FileType", {
            pattern = self.ft,
            callback = function(client, bufnr)
                require("metals").initialize_or_attach(metals_config)
                -- Does not work, sad
                -- vim.api.nvim_buf_create_user_command(bufnr, "MetalsNewScalaFile", function()
                --     vim.cmd("tab split")
                --     require("metals").newScalaFile()
                -- end, {})
            end,
            group = nvim_metals_group,
        })
    end
}
