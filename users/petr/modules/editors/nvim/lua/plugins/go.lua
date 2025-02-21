-- GoLang workspace setup
return {
    {
        'ray-x/go.nvim',
        ft = 'go',
        config = function()
            require('go').setup()
        end
    },

    -- https://github.com/leoluz/nvim-dap-go
    {
        'leoluz/nvim-dap-go',
        dependencies = { 'mfussenegger/nvim-dap' },
        ft = 'go',
        opts = {
            -- :help dap-configuration
            -- dap_configurations = {
            --     {
            --         type = "go",
            --         name = "Attach remote",
            --         mode = "remote",
            --         request = "attach",
            --     },
            -- },

            -- delve configurations
            delve = {
                -- additional args to pass to dlv
                args = {},
                -- the build flags that are passed to delve.
                -- defaults to empty string, but can be used to provide flags
                -- such as "-tags=unit" to make sure the test suite is
                -- compiled during debugging, for example.
                -- passing build flags using args is ineffective, as those are
                -- ignored by delve in dap mode.
                -- avaliable ui interactive function to prompt for arguments get_arguments
                build_flags = {},
            },
        },
        config = function(_, opts)
            local dap_go = require('dap-go')
            dap_go.setup(opts)

            vim.keymap.set('n', '<Leader>df', function() dap_go.debug_test() end)
            vim.keymap.set('n', '<Leader>dF', function() dap_go.debug_last_test() end)
        end
    },
}
