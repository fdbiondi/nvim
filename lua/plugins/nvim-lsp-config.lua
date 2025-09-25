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

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "clangd",
                "cssls",
                "gopls",
                "lua_ls",
                "rust_analyzer",
                "stylelint_lsp",
                "tailwindcss",
                "ts_ls",
                "volar",
                "zls",
            },
            handlers = {}
        })

        local cmp = require('cmp')
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
