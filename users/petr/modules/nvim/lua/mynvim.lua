-- Run VimScript
-- vim.api.nvim_exec2(
-- [[
-- ]],
-- {})

-- vim.api.nvim_command('set number')

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.hlsearch = true
vim.opt.wrap = false
vim.opt.sidescroll = 1
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
-- vim.opt.expandtab = true
vim.opt.fileformat = 'unix'
vim.opt.spelllang = { 'en_us', 'cs' }
vim.opt.spell = true
-- To enable overriding these configurations per project
vim.opt.exrc = true
-- vim.g.mapleader = ',' -- net in the NixOS config, has to be set before loading lazy.nvim

-- Default foldint while tree sitter is not enabled
vim.opt.foldmethod = 'indent'
vim.opt.foldcolumn = 'auto:9'

-- Enables loading of external scrips (.nvim.lua), see :help exrc
vim.o.exrc = true

-- Prevents autocompletion items to be automatically selected
vim.opt.completeopt = 'menu,menuone,preview,noinsert' -- ,noselect

vim.api.nvim_exec2([[
syntax on
filetype plugin on
autocmd BufReadPost *.kt setlocal filetype=kotlin
autocmd BufReadPost *.kts setlocal filetype=kotlin
autocmd BufReadPost *.pl setlocal filetype=prolog
autocmd BufReadPost *.typ setlocal filetype=typst
autocmd BufReadPost *.tera setlocal filetype=htmldjango
autocmd BufReadPost *.tera.html setlocal filetype=htmldjango
autocmd BufReadPost *.html.tera setlocal filetype=htmldjango
autocmd BufReadPost *.frag,*.vert,*.fp,*.vp,*.glsl setlocal filetype=glsl

autocmd FileType verilog setlocal ts=2 sts=2 sw=2 expandtab
]], {})

-- Last column and spaces highlight
vim.opt.colorcolumn = '80'
vim.api.nvim_exec2([[
highlight ColorColumn ctermbg=blue guibg=lightgrey
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
]], {})


vim.cmd([[
if (has("termguicolors"))
    set termguicolors
endif

colorscheme tender
]]
)

local opts = { noremap = true, silent = true }
-- vim.api.nvim_set_keymap("n", "<S-h>", ":bn<CR>", opts)
-- vim.api.nvim_set_keymap("n", "<S-l>", ":bp<CR>", opts)

--- Tree sitter ---------------------------------------------------------------
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufAdd', 'BufNew', 'BufNewFile', 'BufWinEnter' }, {
    group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
    callback = function()
        -- https://neovim.io/doc/user/usr_28.html#usr_28.txt
        vim.opt.foldmethod     = 'expr'
        vim.opt.foldexpr       = 'v:lua.vim.treesitter.foldexpr()'
        vim.opt.foldlevelstart = 1
        vim.opt.foldnestmax    = 5
        vim.opt.foldminlines   = 3
    end
})

-- Images
-- not needed in case I switch to the kitty terminal
require("image").setup({
    backend = "ueberzug",
    -- recommended by Molten
    max_width = 100,                          -- tweak to preference
    max_height = 12,                          -- ^
    max_height_window_percentage = math.huge, -- this is necessary for a good experience
    max_width_window_percentage = math.huge,
    window_overlap_clear_enabled = true,
    window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" }
})


-- Fzf config
vim.api.nvim_set_keymap("n", "<A-f>f", ":Files<CR>", opts)
vim.api.nvim_set_keymap("n", "<A-f>c", ":RG<CR>", opts)
vim.api.nvim_set_keymap("n", "<A-f>b", ":Buffers<CR>", opts)
vim.api.nvim_set_keymap("n", "<A-f>m", ":Maps<CR>", opts)
vim.api.nvim_set_keymap("n", "<A-f>t", ":Types<CR>", opts)

-- Go-to definition in a split window
local function goto_definition(split_cmd)
    local util = vim.lsp.util
    local log = require("vim.lsp.log")
    local api = vim.api

    -- note, this handler style is for neovim 0.5.1/0.6, if on 0.5, call with function(_, method, result)
    local handler = function(_, result, ctx)
        if result == nil or vim.tbl_isempty(result) then
            local _ = log.info() and log.info(ctx.method, "No location found")
            return nil
        end

        if split_cmd then
            vim.cmd(split_cmd)
        end

        if vim.islist(result) then
            util.jump_to_location(result[1])

            if #result > 1 then
                -- util.set_qflist(util.locations_to_items(result))
                vim.fn.setqflist(util.locations_to_items(result))
                api.nvim_command("copen")
                api.nvim_command("wincmd p")
            end
        else
            util.jump_to_location(result)
        end
    end

    return handler
end

vim.lsp.handlers["textDocument/definition"] = goto_definition('vsplit') -- split




-- NVim-cmp setup --------------------------------------------------------------
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require('cmp')
local ls = require('luasnip')

cmp.setup({
    snippet = {
        expand = function(args)
            ls.lsp_expand(args.body)
        end
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        -- ['<CR>'] = cmp.mapping.confirm({ select = true }),
        -- ['<Tab>'] = cmp.mapping(function(fallback)
        --     if cmp.visible() then
        --         cmp.select_next_item()
        --         -- elseif luasnip.expand_or_jumpable() then
        --         -- luasnip.expand_or_jump()
        --     elseif has_words_before() then
        --         cmp.complete()
        --     else
        --         fallback()
        --     end
        -- end, { 'i', 's' }),
        -- ['<S-Tab>'] = cmp.mapping(function(fallback)
        --     if cmp.visible() then
        --         cmp.select_prev_item()
        --         -- elseif luasnip.jumpable(-1) then
        --         --     luasnip.jump(-1)
        --     else
        --         fallback()
        --     end
        -- end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
        { name = 'luasnip',  priority = 100 },
        { name = 'nvim_lsp', priority = 60 },
        { name = 'codeium',  priority = 50 },
        { name = 'lazydev',  priority = 50 },
        -- }, {
        { name = 'buffer',   priority = 40, max_item_count = 5 },
        -- { name = 'omni', priority = 70, },
        { name = 'spell',    priority = 10, keyword_length = 2, },
        { name = 'path',     priority = 20, },
    })
})






-- More keybindings, recommended ones
-- https://github.com/neovim/nvim-lspconfig#suggested-configuration
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Enable inline hints
        vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references)
        vim.keymap.set("n", "gds", vim.lsp.buf.document_symbol)
        vim.keymap.set("n", "gws", vim.lsp.buf.workspace_symbol)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
        vim.keymap.set("n", "<space>cl", vim.lsp.codelens.run)
        vim.keymap.set("n", "<space>sh", vim.lsp.buf.signature_help)
        -- all workspace diagnostics
        vim.keymap.set("n", "<space>aa", vim.diagnostic.setqflist)
        -- all workspace errors
        vim.keymap.set("n", "<space>ae", function()
            vim.diagnostic.setqflist({ severity = "E" })
        end)
        -- all workspace warnings
        vim.keymap.set("n", "<space>aw", function()
            vim.diagnostic.setqflist({ severity = "W" })
        end)
        -- buffer diagnostics only
        vim.keymap.set("n", "<space>d", vim.diagnostic.setloclist)

        vim.keymap.set("n", "[c", function()
            vim.diagnostic.goto_prev({ wrap = false })
        end)
        vim.keymap.set("n", "]c", function()
            vim.diagnostic.goto_next({ wrap = false })
        end)

        -- Show line diagnostics automatically in hover window
        vim.api.nvim_create_autocmd("CursorHold", {
            buffer = ev.buf,
            callback = function()
                local opts = {
                    focusable = false,
                    close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                    border = 'rounded',
                    source = 'always',
                    prefix = ' ',
                    scope = 'cursor',
                }
                vim.diagnostic.open_float(nil, opts)
            end
        })
    end,
})





-- --- cmp plugin special targets ---------------------------------------------
-- Set configuration for specific filetype.

cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' },
    }, {
        { name = 'buffer' },
    })
})

cmp.setup.filetype('lua', {
    sources = cmp.config.sources({
        --     { name = 'nvim_lua' },
        -- }, {
        { name = 'buffer' },
    })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        {
            name = 'path',
            option = {
                trailing_slash = true
            },
        },
    }, {
        { name = 'cmdline' }
    })
})

local configureLanguageServers = function()
    local lspconfig = require('lspconfig')
    -- Connection to LSP hrsh7th/cmp-nvim-lsp --------------------------------------
    local capabilities = require('cmp_nvim_lsp').default_capabilities(
    -- vim.lsp.protocol.make_client_capabilities()
    )

    -- C/C++
    lspconfig.clangd.setup {
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern(
            '.clangd',
            '.clang-tidy',
            '.clang-format',
            'compile_commands.json',
            'compile_flags.txt',
            'configure.ac',
            'Makefile',
            '.git'
        ),
    }

    -- Kotlin
    lspconfig.kotlin_language_server.setup {
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern('settings.gradle.kts', 'settings.gradle', '.git', '*'),
    }

    -- Python
    lspconfig.pyright.setup {
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern('.git', '.venv'),
    }
    -- lspconfig.pylsp.setup {
    --     capabilities = capabilities,
    --     -- settings = {
    --     --   pylsp = {
    --     --     plugins = {
    --     --       pycodestyle = {
    --     --         ignore = {'W391'},
    --     --         maxLineLength = 100
    --     --       }
    --     --     }
    --     --   }
    --     -- }
    -- }


    -- Lua
    lspconfig.lua_ls.setup {
        capabilities = capabilities,
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT',
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = { 'vim' },
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true),
                    -- Remove some weird message
                    checkThirdParty = false,
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                -- telemetry = {
                --     enable = false,
                -- },
            },
        },
    }

    -- Bash
    lspconfig.bashls.setup {
        capabilities = capabilities,
    }

    -- Docker
    lspconfig.dockerls.setup {
        capabilities = capabilities,
    }

    -- LaTex, Tex
    -- https://github.com/latex-lsp/texlab/wiki/Configuration
    lspconfig.texlab.setup {
        capabilities = capabilities,
        before_init = function(params)
            params.processId = vim.NIL
        end,
        settings = {
            texlab = {
                build = {
                    args = {
                        "-pdf",
                        "-interaction=nonstopmode",
                        "-synctex=1",
                        "-auxdir=build",
                        "%f",
                    },
                    auxDirectory = "build",
                    logDirectory = "build",
                    onSave = true,
                    useFileList = true,
                    forwardSearchAfter = true,
                },
                chktex = {
                    onEdit = true,
                    onOpenAndSave = true,
                },
                latexindent = {
                    args = { '-l' },
                },
                experimental = {
                    followPackageLinks = true,
                },
            }
        }
    }

    -- YAML
    lspconfig.yamlls.setup {
        capabilities = capabilities,
        settings = {
            yaml = {
                schemas = {
                    ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                    -- ["../path/relative/to/file.yml"] = "/.github/workflows/*",
                    -- ["/path/from/root/of/project"] = "/.github/workflows/*",
                    ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "/*.k8s.yaml",
                },
            },
        }
    }

    -- Verilog
    lspconfig.svls.setup {
        capabilities = capabilities,
        -- root_dir = lspconfig.util.root_pattern('.git', '*'),
    }

    -- Racket
    lspconfig.racket_langserver.setup {
        capabilities = capabilities,
    }

    -- Rust
    lspconfig.rust_analyzer.setup {
        capabilities = capabilities,
    }

    -- generate tags
    -- https://github.com/dan-t/rusty-tags
    vim.api.nvim_exec2([[
        autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi
        autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!
    ]], {})


    -- English - the worst of them all
    lspconfig.ltex.setup {
        capabilities = capabilities,
        flags = { debounce_text_changes = 300 },
        on_attach = function(client, bufnr)
            require("ltex_extra").setup {
                load_langs = { "en-US" },
                log_lever = "error",
                path = "ltex",
            }
        end,
        settings = {
            ltex = {
                -- https://valentjn.github.io/ltex/settings.html
                language = "en-US",
                completionEnabled = true,
                enabled = {
                    "python", "bibtex", "gitcommit", "markdown", "org", "tex", "restructuredtext", "rsweave", "latex", "quarto", "rmd", "context", "html", "xhtml"
                },
                additional_rules = {
                    enablePickyRules = true,
                    languageModel = "~/language_tool_models/ngrams",
                    word2VecModel = "~/language_tool_models/neuralnetwork",
                },
                -- Easily causes to many requests
                -- languageToolHttpServerUri = "https://api.languagetool.org/",
                -- languageToolOrg = {
                --     username = "",
                --     apiKey = "",
                -- },

                -- possibly not working
                ltexls = {
                    -- logLevel = "config",
                    logLevel = "finest",
                },
            },
        },
    }

    -- Typst
    lspconfig.typst_lsp.setup {
        capabilities = capabilities,
        filetypes = { "typst" },
        root_dir = lspconfig.util.root_pattern('.git', '*'),
    }

    -- GoLang
    lspconfig.gopls.setup {
        capabilities = capabilities,
    }
    require('go').setup({})
    require('dap-go').setup({})

    -- Zig (zls)
    lspconfig.zls.setup {
        capabilities = capabilities,
    }

    -- GLSL - OpenGL
    lspconfig.glsl_analyzer.setup {
        capabilities = capabilities,
    }

    -- CMake
    -- lspconfig.cmake.setup {
    --     capabilities = capabilities,
    -- }
    lspconfig.neocmake.setup {
        capabilities = capabilities,
    }

    -- SQL
    lspconfig.sqls.setup {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
            require('sqls').on_attach(client, bufnr)
        end
    }

    -- Nix
    lspconfig.nixd.setup {
        capabilities = capabilities,
    }
    lspconfig.nil_ls.setup {
        capabilities = capabilities,
        settings = {
            ['nil'] = {
                testSetting = 42,
                formatting = {
                    command = { "nixfmt" },
                },
                nix = {
                    flake = {
                        -- Automatically run `nix flake archive` when necessary.
                        autoArchive = true,
                        -- Whether to auto-eval flake inputs.
                        -- The evaluation result is used to improve completion, but may cost
                        -- lots of time and/or memory.
                        -- autoEvalInputs = true,
                    }
                },
            },
        },
    }
end
configureLanguageServers()


-- Debugging
local dap, dapui = require("dap"), require("dapui")

-- nice UI
dapui.setup()
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

-- Nice inlined text
require("nvim-dap-virtual-text").setup({
    commented = true,
    all_frames = false,
})

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
-- dap.configurations.cpp = {
--   {
--     name = "Launch file",
--     type = "codelldb",
--     request = "launch",
--     program = function()
--       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
--     end,
--     cwd = '${workspaceFolder}',
--     stopOnEntry = false,
--   },
-- }
-- dap.configurations.c = dap.configurations.cpp
-- dap.configurations.rust = dap.configurations.cpp
dap.configurations.python = {
    type = 'python',
    request = 'launch',
    name = 'My custom launch configuration',
    program = '${file}',
}
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



-- Mapping
vim.keymap.set('n', '<F5>', function() dap.continue() end)
vim.keymap.set('n', '<F10>', function() dap.step_over() end)
vim.keymap.set('n', '<F11>', function() dap.step_into() end)
vim.keymap.set('n', '<F12>', function() dap.step_out() end)
vim.keymap.set('n', '<Leader>db', function() dap.toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>dB', function() dap.set_breakpoint() end)
vim.keymap.set('n', '<Leader>dl', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() dap.repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() dap.run_last() end)
-- vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
--     require('dap.ui.widgets').hover()
-- end)
-- vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
--     require('dap.ui.widgets').preview()
-- end)
-- vim.keymap.set('n', '<Leader>df', function()
--     local widgets = require('dap.ui.widgets')
--     widgets.centered_float(widgets.frames)
-- end)
-- vim.keymap.set('n', '<Leader>ds', function()
--     local widgets = require('dap.ui.widgets')
--     widgets.centered_float(widgets.scopes)
-- end)


-- Python
local dap_python = require('dap-python')
-- dap_python.setup('/home/petr/.local/lib/python3.11')
dap_python.setup('/bin/python3')
dap_python.test_runner = 'pytest'
vim.keymap.set('n', '<Leader>df', function() dap_python.test_method() end)
vim.keymap.set('n', '<Leader>dc', function() dap_python.test_class() end)
vim.keymap.set('v', '<Leader>ds', function() dap_python.debug_selection() end)

-- TODO implement DAP, these are taken from metals-scala
-- map("n", "<leader>dc", function()
--     require("dap").continue()
-- end)

-- map("n", "<leader>dr", function()
--     require("dap").repl.toggle()
-- end)

-- map("n", "<leader>dK", function()
--     require("dap.ui.widgets").hover()
-- end)

-- map("n", "<leader>dt", function()
--     require("dap").toggle_breakpoint()
-- end)

-- map("n", "<leader>dso", function()
--     require("dap").step_over()
-- end)

-- map("n", "<leader>dsi", function()
--     require("dap").step_into()
-- end)

-- map("n", "<leader>dl", function()
--     require("dap").run_last()
-- end)



-- NerdTree setup
-- vim.api.nvim_exec2([[
-- nnoremap <leader>n :NERDTreeFocus<CR>
-- " nnoremap <C-n> :NERDTree<CR>
-- nnoremap <C-t> :NERDTreeToggle<CR>
-- " nnoremap <C-f> :NERDTreeFind<CR>
-- nnoremap <C-h> :NERDTreeFocus<CR>

-- " Start NERDTree and put the cursor back in the other window.
-- " autocmd VimEnter * NERDTree | wincmd p

-- " Close the tab if NERDTree is the only window remaining in it.
-- autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

-- " If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
-- autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
--     \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

-- " Open the existing NERDTree on each new tab.
-- " autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif

-- " Open NERDTree when vim is opened without args, but not with
-- autocmd StdinReadPre * let g:isReadingFromStdin = 1
-- autocmd VimEnter * if !argc() && !exists('g:isReadingFromStdin') | NERDTree | endif
-- " autocmd VimEnter * if !argc() && !exists('g:isReadingFromStdin') | NERDTree | wincmd p | endif

-- set modifiable
-- ]], {})
