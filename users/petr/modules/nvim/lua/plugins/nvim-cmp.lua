-- Serves autocompletion menu

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
    'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    dependencies = {
        -- Communication with nvim lsp server
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-path',
        -- 'hrsh7th/cmp-omni',

        -- Autocomplete NVim lua api
        -- 'hrsh7th/cmp-nvim-lua',

        -- Add spelling support
        'f3fora/cmp-spell',

        -- Snippets, proper config is in luasnip.lua
        'saadparwaiz1/cmp_luasnip',

        -- LSP servers management
        'neovim/nvim-lspconfig',
    },
    config = function()
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
                -- { name = 'codeium',  priority = 50 },
                { name = 'lazydev',  priority = 50 },
                -- }, {
                { name = 'buffer',   priority = 40, max_item_count = 5 },
                -- { name = 'omni', priority = 70, },
                { name = 'spell',    priority = 10, keyword_length = 2, },
                { name = 'path',     priority = 20, },
            })
        })

        -- Buffer specific sources
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

        -- dismiss neocodeium suggestions
        cmp.event:on("menu_opened", function()
            local neocodeium = require("neocodeium")
            neocodeium.clear()
        end)
    end,
}
