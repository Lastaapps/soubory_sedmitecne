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
