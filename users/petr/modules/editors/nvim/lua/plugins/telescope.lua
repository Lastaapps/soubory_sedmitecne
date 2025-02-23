return {
    {
        'nvim-telescope/telescope.nvim',
        event = "VimEnter",
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release',
            },
        },
        config = function()
            local tel_builtin = require('telescope.builtin')
            -- Trouble integration
            local open_with_trouble = require("trouble.sources.telescope").open
            -- Use this to add more results without clearing the trouble list
            local add_to_trouble = require("trouble.sources.telescope").add

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
                            ["<C-s>"] = open_with_trouble, -- [s]ave
                            ["<C-a>"] = add_to_trouble,    -- [a]dd
                        },
                        n = {
                            ["<C-s>"] = open_with_trouble,
                            ["<C-a>"] = add_to_trouble,
                        },
                    },
                    file_ignore_patterns = {
                        ".git/",
                        ".cache",
                        ".idea",
                        ".venv/",
                        "data/",
                        "target/",
                        "build/",
                        "%.o",
                        "%.a",
                        "%.out",
                        "%.class",
                        "%.pdf",
                        "%.mkv",
                        "%.mp4",
                        "%.zip",
                    },
                },
                pickers = {
                    find_files = {
                        hidden = true,
                    },
                },
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

            vim.keymap.set('n', '<leader>ff', tel_builtin.find_files,
                { desc = "[F]ind [F]iles", })
            vim.keymap.set('n', '<leader>fg', tel_builtin.live_grep,
                { desc = "[F]ind using [G]rep", })
            vim.keymap.set('n', '<leader>fb', tel_builtin.buffers,
                { desc = "[F]ind opened [B]uffers", })
            vim.keymap.set('n', '<leader>fh', tel_builtin.help_tags,
                { desc = "[F]ind [H]elp tags", })
            vim.keymap.set('n', '<leader>fws', tel_builtin.lsp_workspace_symbols,
                { desc = "[F]ind [W]orsace [S]ymbols", })
            vim.keymap.set('n', '<leader>fds', tel_builtin.lsp_document_symbols,
                { desc = "[F]ind [D]ocument [S]ymbols", })
            vim.keymap.set('n', '<leader>fr', tel_builtin.lsp_references,
                { desc = "[F]ind LSP [R]eferences", })
            vim.keymap.set('n', '<leader>fci', tel_builtin.lsp_incoming_calls,
                { desc = "[F]ind LSP [C]alls - [I]ncomming", })
            vim.keymap.set('n', '<leader>fco', tel_builtin.lsp_outgoing_calls,
                { desc = "[F]ind LSP [C]alls - [O]utgoing", })
            -- vim.keymap.set('n', 'gd', tel_builtin.lsp_definitions, {})
            -- <C-x> go to file selection as a split
            -- <C-v> go to file selection as a vsplit
            -- <C-t> go to a file in a new tab



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
