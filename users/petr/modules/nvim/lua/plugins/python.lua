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

    -- Requires Python package debugpy
    {
        'mfussenegger/nvim-dap-python',
        dependencies = { 'mfussenegger/nvim-dap' },
        ft = 'python',
        config = function()
            local dap_python = require('dap-python')
            dap_python.setup("/usr/bin/env python3")
            dap_python.test_runner = 'pytest'

            vim.keymap.set('n', '<Leader>df', function() dap_python.test_method() end)
            vim.keymap.set('n', '<Leader>dc', function() dap_python.test_class() end)
            vim.keymap.set('v', '<Leader>ds', function() dap_python.debug_selection() end)
        end
    },
}
