return {
    {
        'neovim/nvim-lspconfig',
        event = "VeryLazy",
        dependencies = {
            "antosha417/nvim-lsp-file-operations",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local capabilities = vim.tbl_deep_extend(
                "force",
                vim.lsp.protocol.make_client_capabilities(),
                require('lsp-file-operations').default_capabilities(),
                require('cmp_nvim_lsp').default_capabilities()
            )

            local ltex_filetypes = {
                "bash", "c", "cpp", "go", "haskell", "json", "lua", "python", "rust", "typst", "yaml", "zip",
                "bib", "gitcommit", "markdown", "org", "plaintex", "rst", "rnoweb", "tex", "pandoc", "quarto",
                "rmd", "context", "html", "xhtml", "mail", "text",
            }

            local servers = {
                clangd = {
                    root_markers = { '.clangd', '.clang-tidy', '.clang-format', 'compile_commands.json', 'compile_flags.txt', 'configure.ac', 'Makefile', '.git' },
                },
                kotlin_language_server = {
                    root_markers = { 'settings.gradle.kts', 'settings.gradle', '.git' },
                },
                lua_ls = {
                    settings = {
                        Lua = {
                            runtime = { version = 'LuaJIT' },
                            diagnostics = { globals = { 'vim' } },
                            workspace = {
                                library = vim.api.nvim_get_runtime_file("", true),
                                checkThirdParty = false,
                            },
                        },
                    },
                },
                bashls = {},
                dockerls = {},
                texlab = {
                    settings = {
                        texlab = {
                            build = {
                                args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "-auxdir=build", "%f" },
                                auxDirectory = "build",
                                logDirectory = "build",
                                onSave = true,
                                useFileList = true,
                                forwardSearchAfter = true,
                            },
                            chktex = { onEdit = true, onOpenAndSave = true },
                            latexindent = { args = { '-l' } },
                            experimental = { followPackageLinks = true },
                        }
                    }
                },
                yamlls = {
                    settings = {
                        yaml = {
                            schemas = {
                                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                                ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] =
                                "/*.k8s.yaml",
                            },
                        }
                    }
                },
                svls = {},
                racket_langserver = {},
                rust_analyzer = {},
                ltex_plus = {
                    filetypes = ltex_filetypes,
                    flags = { debounce_text_changes = 300 },
                    on_attach = function()
                        require("ltex_extra").setup {
                            load_langs = { "en-US" },
                            log_lever = "error",
                            path = "ltex",
                        }
                    end,
                    settings = {
                        ltex = {
                            language = "en-US",
                            completionEnabled = true,
                            enabled = ltex_filetypes,
                            additional_rules = { enablePickyRules = true },
                            ltex_ls = { logLevel = "config" },
                        },
                    },
                },
                vale_ls = {
                    filetypes = ltex_filetypes,
                    single_file_support = false,
                },
                tinymist = {
                    root_markers = { '.git' }, -- tinymist usually detects root well, but explicit marker added
                },
                gopls = {},
                zls = {},
                glsl_analyzer = {},
                neocmake = {},
                sqls = {
                    on_attach = function(client, bufnr)
                        require('sqls').on_attach(client, bufnr)
                    end
                },
                nixd = {},
                nil_ls = {
                    settings = {
                        ['nil'] = {
                            testSetting = 42,
                            formatting = { command = { "nixfmt" } },
                            nix = { flake = { autoArchive = true } },
                        },
                    },
                },
                hls = {
                    filetypes = { 'haskell', 'lhaskell', 'cabal' },
                },
                elmls = {},
            }

            -- 4. Logic Branches
            -- Python selection
            local use_pyright = true
            if use_pyright then
                servers.pyright = {
                    root_markers = { '.git', '.venv', 'pyproject.toml' },
                }
            else
                servers.pylsp = {}
            end

            -- 5. Application Loop
            -- Apply configuration and enable
            for server, config in pairs(servers) do
                -- Inject standard capabilities into every config
                config.capabilities = vim.tbl_deep_extend("force", capabilities, config.capabilities or {})

                -- Register the config (merges with nvim-lspconfig's defaults automatically)
                vim.lsp.config[server] = config

                -- Activate the server (sets up FileType autocommands)
                vim.lsp.enable(server)
            end
        end
    },
    {
        "antosha417/nvim-lsp-file-operations",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("lsp-file-operations").setup()
        end,
    },
}
