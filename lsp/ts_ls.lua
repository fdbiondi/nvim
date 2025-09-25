local cmp_lsp = require("cmp_nvim_lsp")
local capabilities = vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities(),
    cmp_lsp.default_capabilities())

-- local mason_packages = vim.fn.stdpath("data") .. "/mason/packages"
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

return {
    -- NOTE: To enable hybridMode, change HybrideMode to true above and uncomment the following filetypes block.

    filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx', 'vue', },
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
                includeInlayParameterNameHints = "literals",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = false,
                includeInlayVariableTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
            },
        },

        javascript = {
            inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = false,
            },
        },
    },
}
