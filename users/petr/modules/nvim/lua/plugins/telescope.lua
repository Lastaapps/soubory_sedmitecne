return {
    {
        'nvim-telescope/telescope.nvim',
        lazy = false,
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release',
            },
        },
        config = function()
            local tel_builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', tel_builtin.find_files, {})
            vim.keymap.set('n', '<leader>fg', tel_builtin.live_grep, {})
            vim.keymap.set('n', '<leader>fb', tel_builtin.buffers, {})
            vim.keymap.set('n', '<leader>fh', tel_builtin.help_tags, {})
            vim.keymap.set('n', '<leader>fws', tel_builtin.lsp_workspace_symbols, {})
            vim.keymap.set('n', '<leader>fds', tel_builtin.lsp_document_symbols, {})
            vim.keymap.set('n', '<leader>fr', tel_builtin.lsp_references, {})
            vim.keymap.set('n', '<leader>fci', tel_builtin.lsp_incoming_calls, {})
            vim.keymap.set('n', '<leader>fco', tel_builtin.lsp_outgoing_calls, {})
            -- vim.keymap.set('n', 'gd', tel_builtin.lsp_definitions, {})
            -- <C-x> go to file selection as a split
            -- <C-v> go to file selection as a vsplit
            -- <C-t> go to a file in a new tab

            local telescope = require('telescope')
            telescope.setup {
                defaults = {
                    mappings = {
                        i = {
                            -- Select the option under cursor
                            ["<C-y>"] = "select_default",
                            -- map actions.which_key to <C-h> (default: <C-/>)
                            -- actions.which_key shows the mappings for your picker,
                            -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                            ["<C-h>"] = "which_key",
                        },
                    }
                },
                pickers = {},
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    }
                },
            }
            -- Load extensions
            telescope.load_extension('fzf')



            -- Telescope UI for Harpoon
            -- TODO enable after harpoon
            -- local harpoon = require("harpoon")
            -- local tel_conf = require("telescope.config").values
            -- local function toggle_telescope(harpoon_files)
            --     local file_paths = {}
            --     for _, item in ipairs(harpoon_files.items) do
            --         table.insert(file_paths, item.value)
            --     end
            --
            --     require("telescope.pickers").new({}, {
            --         prompt_title = "Harpoon",
            --         finder = require("telescope.finders").new_table({
            --             results = file_paths,
            --         }),
            --         previewer = tel_conf.file_previewer({}),
            --         sorter = tel_conf.generic_sorter({}),
            --     }):find()
            -- end
            -- vim.keymap.set("n", "<leader>e", function() toggle_telescope(harpoon:list()) end,
            --     { desc = "Open harpoon window" })
        end
    },
}
