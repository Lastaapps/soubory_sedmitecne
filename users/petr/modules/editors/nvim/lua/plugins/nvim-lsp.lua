-- Configure communication with LSP servers

-- Set configuration for specific filetype.
local configureLanguageServers = function()
    local lspconfig = require('lspconfig')
    -- Connection to LSP hrsh7th/cmp-nvim-lsp
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
    local use_pyright = true
    if use_pyright then
        lspconfig.pyright.setup {
            capabilities = capabilities,
            root_dir = lspconfig.util.root_pattern('.git', '.venv'),
        }
    else
        lspconfig.pylsp.setup {
            capabilities = capabilities,
            -- settings = {
            --   pylsp = {
            --     plugins = {
            --       pycodestyle = {
            --         ignore = {'W391'},
            --         maxLineLength = 100
            --       }
            --     }
            --   }
            -- }
        }
    end


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

    -- English - the worst of them all
    local ltex_vim_filetypes = {
        -- ltex server uses VSCode like file types that do not always match with NVim
        -- ltex-plus NVim integration maps the most annoying of them (the default ones),
        -- still note that if an added language does not work,
        -- check the VSCode list and add both the names
        -- https://code.visualstudio.com/docs/languages/identifiers
        -- Non-supported languages are checked as plain files,
        -- remove them from this list if found
        "bash",
        "c", "cpp",
        "go",
        "haskell",
        "json",
        "lua",
        "python",
        "rust",
        "typst",
        "yaml",
        "zip",
        -- defaults
        "bib", "gitcommit", "markdown", "org", "plaintex", "rst", "rnoweb", "tex", "pandoc", "quarto", "rmd", "context",
        "html", "xhtml", "mail", "text",
    }
    lspconfig.ltex_plus.setup {
        capabilities = capabilities,
        flags = { debounce_text_changes = 300 },
        on_attach = function(client, bufnr)
            require("ltex_extra").setup {
                load_langs = { "en-US" },
                log_lever = "error",
                path = "ltex",
            }
        end,
        filetypes = ltex_vim_filetypes,
        settings = {
            -- https://valentjn.github.io/ltex/settings.html
            ltex = {
                -- https://valentjn.github.io/ltex/settings.html
                language = "en-US",
                completionEnabled = true,
                enabled = ltex_vim_filetypes,
                additional_rules = {
                    enablePickyRules = true,
                    -- languageModel = "~/language_tool_models/ngrams",
                },
                -- Easily causes to many requests
                -- languageToolHttpServerUri = "http://localhost:8081/",
                -- languageToolHttpServerUri = "https://api.languagetool.org/",
                -- languageToolOrg = {
                --     username = "",
                --     apiKey = "",
                -- },

                -- possibly not working
                ltex_ls = {
                    -- logLevel = "severe",
                    logLevel = "config",
                    -- logLevel = "finest",
                },
            },
        },
    }
    -- Vale Linter for English
    lspconfig.vale_ls.setup {
        capabilities = capabilities,
        -- filetypes = { "markdown", "text", "plain", "tex", "rst" },
        filetypes = ltex_vim_filetypes,
        single_file_support = false, -- runs only if a config file is found
    }

    -- Typst
    lspconfig.tinymist.setup {
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern('.git', '*'),
    }

    -- GoLang
    lspconfig.gopls.setup {
        capabilities = capabilities,
    }

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

    -- Haskell
    -- set using the haskel-tools
    lspconfig.hls.setup {
        capabilities = capabilities,
        filetypes = { 'haskell', 'lhaskell', 'cabal' },
    }

    -- Elm
    lspconfig.elmls.setup {
        capabilities = capabilities,
    }
end

return {
    {
        'neovim/nvim-lspconfig',
        event = "BufReadPost",
        config = function()
            configureLanguageServers()
        end
    },
}
