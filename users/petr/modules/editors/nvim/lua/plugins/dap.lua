-- NVim debugger

local ui_config = function()
    local dap, dapui = require("dap"), require("dapui")

    -- nice UI
    dap.listeners.before.attach.dapui_config = function()
        dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
    end
end

local adapters = function()
    local dap = require("dap")

    -- Adapters
    dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "-i", "dap" }
    }
    dap.adapters.codelldb = {
        type = 'server',
        port = "${port}",
        executable = {
            command = '/usr/bin/codelldb',
            args = { "--port", "${port}" },
        }
    }
end

local configurations = function()
    local dap = require("dap")

    -- Language specific launch options
    dap.configurations.c = {
        {
            name = "Launch",
            type = "gdb",
            request = "launch",
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = "${workspaceFolder}",
            stopAtBeginningOfMainSubprogram = false,
        },
    }
    dap.configurations.cpp = dap.configurations.c
    dap.configurations.rust = dap.configurations.c

    -- https://github.com/mfussenegger/nvim-dap-python?tab=readme-ov-file#custom-configuration
    -- dap.configurations.python = {
    --     type = 'python',
    --     request = 'launch',
    --     name = 'My custom launch configuration',
    --     program = '${file}',
    -- }

    dap.configurations.scala = {
        {
            type = "scala",
            request = "launch",
            name = "RunOrTest",
            metals = {
                runType = "runOrTestFile",
                --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
            },
        },
        {
            type = "scala",
            request = "launch",
            name = "Test Target",
            metals = {
                runType = "testTarget",
            },
        },
    }
end

local keymaps = function()
    local dap = require("dap")

    -- More specific keymaps are set in the language specific plugins
    -- like Python or Go.

    vim.keymap.set('n', '<F5>', function() dap.continue() end)
    vim.keymap.set('n', '<F10>', function() dap.step_over() end)
    vim.keymap.set('n', '<F11>', function() dap.step_into() end)
    vim.keymap.set('n', '<F12>', function() dap.step_out() end)
    vim.keymap.set('n', '<Leader>db', function() dap.toggle_breakpoint() end)
    vim.keymap.set('n', '<Leader>dB', function() dap.set_breakpoint() end)
    vim.keymap.set('n', '<Leader>dl', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
    vim.keymap.set('n', '<Leader>dr', function() dap.repl.open() end)
    vim.keymap.set('n', '<Leader>dl', function() dap.run_last() end)

    local widgets = require('dap.ui.widgets')
    vim.keymap.set({ 'n', 'v' }, '<Leader>dh', widgets.hover)
    vim.keymap.set({ 'n', 'v' }, '<Leader>dp', widgets.preview)
    vim.keymap.set('n', '<Leader>df', function()
        widgets.centered_float(widgets.frames)
    end)
    vim.keymap.set('n', '<Leader>ds', function()
        widgets.centered_float(widgets.scopes)
    end)
end

return {
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            "rcarriga/nvim-dap-ui",
            'theHamsta/nvim-dap-virtual-text',
        },
        config = function()
            adapters()
            configurations()
        end
    },


    -- Shortcuts in individual panels
    -- edit: e
    -- expand: <CR> or left click
    -- open: o
    -- remove: d
    -- repl: r
    -- toggle: t
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        config = function()
            require("dap")
            require("dapui").setup()
            ui_config()
            keymaps()
        end
    },

    {
        'theHamsta/nvim-dap-virtual-text',
        opts = {
            commented = true,
            all_frames = false,
        },
    },
}
