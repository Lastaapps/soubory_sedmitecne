-- Run VimScript
-- vim.api.nvim_exec(
-- [[
-- ]],
-- true)

-- vim.api.nvim_command('set number')


-- Packer
require('plugins')


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
vim.opt.fileformat = 'unix'
vim.opt.spell = true
vim.opt.spelllang = { 'en_us', 'cs' }
-- To enable overriding these configurations per project
vim.opt.exrc = true

vim.api.nvim_exec([[
syntax on
filetype plugin on
autocmd BufReadPost *.kt setlocal filetype=kotlin
autocmd BufReadPost *.kts setlocal filetype=kotlin
autocmd BufReadPost *.pl setlocal filetype=prolog
autocmd BufReadPost *.typ setlocal filetype=typst
autocmd BufReadPost *.tera setlocal filetype=htmldjango
autocmd BufReadPost *.tera.html setlocal filetype=htmldjango
autocmd BufReadPost *.html.tera setlocal filetype=htmldjango

autocmd FileType verilog setlocal ts=2 sts=2 sw=2 expandtab
]], true)

-- Last column and spaces highlight
vim.opt.colorcolumn = '80'
vim.api.nvim_exec([[
highlight ColorColumn ctermbg=blue guibg=lightgrey
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
]], true)


vim.cmd([[
if (has("termguicolors"))
    set termguicolors
endif

colorscheme tender
]]
)

--- Tree sitter ---------------------------------------------------------------
require('nvim-treesitter.configs').setup {
    ensure_installed = "all",
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    ident = { enable = true },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
    },
    matchup = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            -- set to `false` to disable one of the mappings
            init_selection = "gnn",
            scope_incremental = "grc",
            node_incremental = "grn",
            node_decremental = "grm",
        },
    },
}
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufAdd', 'BufNew', 'BufNewFile', 'BufWinEnter' }, {
    group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
    callback = function()
        vim.opt.foldmethod = 'expr'
        vim.opt.foldexpr   = 'nvim_treesitter#foldexpr()'
        vim.opt.foldenable = false
    end
})

-- nvim-cmp autocompletion

-- NVim-cmp setup -------------------------------------------------------------------
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require('cmp')
local lspconfig = require('lspconfig')

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        end,
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
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
                -- elseif luasnip.expand_or_jumpable() then
                -- luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
                -- elseif luasnip.jumpable(-1) then
                --     luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        -- {
        --     name = 'vsnip',
        --     max_item_count = 3,
        -- },
    }, {
        { name = 'buffer' },
        -- { name = 'omni', priority = 70, },
        {
            name = "dictionary",
            keyword_length = 2,
            priority = 10,
        },
        { name = 'spell',  priority = 30, },
        { name = 'buffer', priority = 30, },
        { name = 'path',   priority = 20, },
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

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
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
        { name = 'nvim_lua' },
    }, {
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




-- Dictionary setup uga-rosa/cmp-dictionary ------------------------------------
require("cmp_dictionary").setup({
    dic = {
        ["*"] = { "/etc/aspell/en.dict" },
        spelllang = {
            en = "/etc/aspell/en.dict",
        },
    },
    -- The following are default values.
    exact = 2,
    first_case_insensitive = true,
    document = false,
    document_command = "wn %s -over",
    async = true,
    capacity = 5,
    debug = false,
})

-- Setup f3fora/cmp-spell
vim.opt.spell = true
vim.opt.spelllang = { 'en_us' }



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
            telemetry = {
                enable = false,
            },
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
lspconfig.texlab.setup {
    capabilities = capabilities,
    settings = {
        texlab = {
            auxDirectory = ".",
            bibtexFormatter = "texlab",
            build = {
                args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
                executable = "latexmk",
                forwardSearchAfter = false,
                onSave = false
            },
            chktex = {
                onEdit = false,
                onOpenAndSave = false
            },
            diagnosticsDelay = 300,
            formatterLineLength = 80,
            forwardSearch = {
                args = {}
            },
            latexFormatter = "latexindent",
            latexindent = {
                modifyLineBreaks = false
            }
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
local rt = require("rust-tools")

rt.setup({
    server = {
        on_attach = function(_, bufnr)
            -- Hover actions
            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
        end,
    },
})
rt.inlay_hints.enable()
rt.hover_actions.hover_actions()

-- generate tags
-- https://github.com/dan-t/rusty-tags
vim.api.nvim_exec([[
    autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi
    autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!
]], true)


-- English - the worst of them all
lspconfig.ltex.setup {
    -- on_attach = on_attach,
    cmd = { "ltex-ls" },
    flags = { debounce_text_changes = 300 },
    filetypes = { "bib", "gitcommit", "markdown", "org", "plaintex", "rst", "rnoweb", "tex", "pandoc", "text" },
}

-- Typst
lspconfig.typst_lsp.setup {
    filetypes = { "typst" },
    root_dir = lspconfig.util.root_pattern('.git', '*'),
}

-- GoLang (gopls)
lspconfig.gopls.setup{}


-- -- Vimspector options
-- vim.cmd([[
-- let g:vimspector_sidebar_width = 85
-- let g:vimspector_bottombar_height = 15
-- let g:vimspector_terminal_maxwidth = 70
-- ]])
-- -- Vimspector
-- vim.cmd([[
-- nmap <F9> <cmd>call vimspector#Launch()<cr>
-- nmap <F5> <cmd>call vimspector#StepOver()<cr>
-- nmap <F8> <cmd>call vimspector#Reset()<cr>
-- nmap <F11> <cmd>call vimspector#StepOver()<cr>")
-- nmap <F12> <cmd>call vimspector#StepOut()<cr>")
-- nmap <F10> <cmd>call vimspector#StepInto()<cr>")
-- ]])
-- vim.cmd.map('n', "Db", ":call vimspector#ToggleBreakpoint()<cr>")
-- vim.cmd.map('n', "Dw", ":call vimspector#AddWatch()<cr>")
-- vim.cmd.map('n', "De", ":call vimspector#Evaluate()<cr>")


-- NerdTree setup
vim.api.nvim_exec([[
nnoremap <leader>n :NERDTreeFocus<CR>
" nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
" nnoremap <C-f> :NERDTreeFind<CR>
nnoremap <C-h> :NERDTreeFocus<CR>

" Start NERDTree and put the cursor back in the other window.
" autocmd VimEnter * NERDTree | wincmd p

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" Open the existing NERDTree on each new tab.
" autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif

" Open NERDTree when vim is opened without args, but not with
autocmd StdinReadPre * let g:isReadingFromStdin = 1
autocmd VimEnter * if !argc() && !exists('g:isReadingFromStdin') | NERDTree | endif
" autocmd VimEnter * if !argc() && !exists('g:isReadingFromStdin') | NERDTree | wincmd p | endif

set modifiable
]], true)
