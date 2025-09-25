local cmp_lsp = require("cmp_nvim_lsp")
local capabilities = vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities(),
    cmp_lsp.default_capabilities())

return {
    -- NOTE: Uncomment to enable volar in file types other than vue.
    -- (Similar to Takeover Mode)

    filetypes = { "vue", "javascript", "typescript", "javascriptreact", "typescriptreact", "json" },

    -- NOTE: Uncomment to restrict Volar to only Vue/Nuxt projects. This will enable Volar to work alongside other language servers (tsserver).

    root_dir = vim.lsp.config.util.root_markers(
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
}
