return {
    "neovim/nvim-lspconfig",

    dependencies = {
        "stevearc/conform.nvim",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",

        -- Completion framework:
        "hrsh7th/nvim-cmp",

        -- LSP completion source:
        "hrsh7th/cmp-nvim-lsp",

        -- Useful completion sources:
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",

        "hrsh7th/cmp-vsnip",
        "hrsh7th/vim-vsnip",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",

        "j-hui/fidget.nvim",
    },

    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                -- Conform will run multiple formatters sequentially
                go = { "goimports", "gofmt" },
                -- You can also customize some of the format options for the filetype
                rust = { "rustfmt", lsp_format = "fallback" },
                -- Conform will run the first available formatter
                javascript = { "prettierd", "prettier", stop_after_first = true },
            }
        })

        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "gopls",
                "clangd",
                "stylelint_lsp",
                "tailwindcss",
                "cssls",
                "ts_ls",
                -- "volar",
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,

                zls = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.zls.setup({
                        root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
                        settings = {
                            zls = {
                                enable_inlay_hints = true,
                                enable_snippets = true,
                                warn_style = true,
                            },
                        },
                    })
                    vim.g.zig_fmt_parse_errors = 0
                    vim.g.zig_fmt_autosave = 0
                end,

                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                }
                                workspace = {
                                    library = {
                                        vim.fn.stdpath('data') .. '/lazy/lazydev.nvim/lua',
                                        -- Add other library paths as needed
                                    }
                                }
                            }

                        }
                    }
                end,

                ["gopls"] = function()
                    local lspconfig = require("lspconfig")
                    local util = require("lspconfig/util")
                    lspconfig.gopls.setup {
                        capabilities = capabilities,
                        cmd = { "gopls", "serve" },
                        filetypes = { "go", "gomod", "gowork", "gotmpl" },
                        root_dir = util.root_pattern("go.work", "go.mod", ".git"),
                        fillstruct = 'gopls',
                        dap_debug = true,
                        dap_debug_gui = true,
                        settings = {
                            gopls = {
                                analyses = {
                                    unusedparams = true,
                                },
                                completeUnimported = true,
                                staticcheck = true,
                                usePlaceholders = true,
                            },
                        },
                    }
                end,

                ["rust_analyzer"] = function()
                    --
                end,

                ["volar"] = function()
                    require("lspconfig").volar.setup({
                        -- NOTE: Uncomment to enable volar in file types other than vue.
                        -- (Similar to Takeover Mode)

                        filetypes = { "vue", "javascript", "typescript", "javascriptreact", "typescriptreact", "json" },

                        -- NOTE: Uncomment to restrict Volar to only Vue/Nuxt projects. This will enable Volar to work alongside other language servers (tsserver).

                        root_dir = require("lspconfig").util.root_pattern(
                            "vue.config.js",
                            "vue.config.ts",
                            "nuxt.config.js",
                            "nuxt.config.ts"
                        ),
                        init_options = {
                            vue = {
                                hybridMode = true,
                            },
                        },
                        capabilities = capabilities,
                        settings = {
                            typescript = {
                                inlayHints = {
                                    enumMemberValues = {
                                        enabled = true,
                                    },
                                    functionLikeReturnTypes = {
                                        enabled = true,
                                    },
                                    propertyDeclarationTypes = {
                                        enabled = true,
                                    },
                                    parameterTypes = {
                                        enabled = true,
                                        suppressWhenArgumentMatchesName = true,
                                    },
                                    variableTypes = {
                                        enabled = true,
                                    },
                                },
                            },
                        },
                    })
                end,

                ["ts_ls"] = function()
                    local mason_packages = vim.fn.stdpath("data") .. "/mason/packages"
                    -- local volar_path = mason_packages .. "/vue-language-server/node_modules/@vue/language-server"

                    -- require("lspconfig").eslint.setup({
                    --     capabilities = capabilities,
                    --     on_new_config = function(config, new_root_dir)
                    --         config.settings.workspaceFolder = {
                    --             uri = vim.uri_from_fname(new_root_dir),
                    --             name = vim.fn.fnamemodify(new_root_dir, ':t')
                    --         }
                    --     end,
                    -- })

                    require("lspconfig").ts_ls.setup({
                        -- NOTE: To enable hybridMode, change HybrideMode to true above and uncomment the following filetypes block.

                        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
                        init_options = {
                            -- plugins = {
                            --     {
                            --         name = "@vue/typescript-plugin",
                            --         location = volar_path,
                            --         languages = { "vue" },
                            --     },
                            -- },
                        },
                        capabilities = capabilities,
                        settings = {
                            typescript = {
                                tsserver = {
                                    useSyntaxServer = false,
                                },
                                inlayHints = {
                                    includeInlayParameterNameHints = "all",
                                    includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                                    includeInlayFunctionParameterTypeHints = true,
                                    includeInlayVariableTypeHints = true,
                                    includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                                    includeInlayPropertyDeclarationTypeHints = true,
                                    includeInlayFunctionLikeReturnTypeHints = true,
                                    includeInlayEnumMemberValueHints = true,
                                },
                            },
                        },
                    })
                end,
            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),

                ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                ['<C-d>'] = cmp.mapping.scroll_docs(4),

                -- Ctrl+Space to trigger completion menu
                ['<C-Space>'] = cmp.mapping.complete(),

                -- Navigate between snippet placeholder
                -- ['<C-f>'] = cmp.mapping.luasnip_jump_forward(),
                -- ['<C-b>'] = cmp.mapping.luasnip_jump_backward(),
            }),
            sources = cmp.config.sources({
                { name = "path" },                                       -- file paths
                { name = "luasnip" },                                    -- luasnip source
                { name = "nvim_lsp",               keyword_length = 1 }, -- from language server
                { name = "nvim_lsp_signature_help" },                    -- func signature
                { name = "nvim_lua",               keyword_length = 1 }, -- complete neovim's Lua runtime API such vim.lsp.*
            }, {
                { name = "buffer", keyword_length = 3 },                 -- source current buffer
            })
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}
