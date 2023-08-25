local lsp = require('lsp-zero').preset('recommended')

lsp.on_attach(function(_, bufnr)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = bufnr, desc = '[R]e[n]ame' })
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, desc = '[C]ode [A]ction' })

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = '[G]oto [D]efinition' })
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, desc = '[G]oto [D]eclaration' })
    vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, { buffer = bufnr, desc = '[G]oto [I]mplementation' })
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, { buffer = bufnr, desc = 'Type [D]efinition' })
    vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references,
        { buffer = bufnr, desc = '[G]oto [R]eferences' })

    vim.keymap.set('n', '<leader>vds', require('telescope.builtin').lsp_document_symbols,
        { buffer = bufnr, desc = '[D]ocument [S]ymbols' })
    vim.keymap.set('n', '<leader>vws', require('telescope.builtin').lsp_dynamic_workspace_symbols,
        { buffer = bufnr, desc = '[W]orkspace [S]ymbols' })

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'Hover Documentation' })
    vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'Signature Documentation' })

    -- Diagnostic keymaps
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { buffer = bufnr, desc = 'Go to previous diagnostic message' })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { buffer = bufnr, desc = 'Go to next diagnostic message' })
    vim.keymap.set('n', '<leader>ve', vim.diagnostic.open_float,
        { buffer = bufnr, desc = 'Open floating diagnostic message' })
    vim.keymap.set('n', '<leader>vq', vim.diagnostic.setloclist, { buffer = bufnr, desc = 'Open diagnostics list' })
    vim.keymap.set('n', '<leader>vdl', '<cmd>Telescope diagnostics<CR>',
        { buffer = bufnr, desc = 'Open telescope diagnostics list' })

    -- Lesser used LSP functionality
    vim.keymap.set('n', '<leader>vwa', vim.lsp.buf.add_workspace_folder,
        { buffer = bufnr, desc = '[W]orkspace [A]dd Folder' })
    vim.keymap.set('n', '<leader>vwr', vim.lsp.buf.remove_workspace_folder,
        { buffer = bufnr, desc = '[W]orkspace [R]emove Folder' })
    vim.keymap.set('n', '<leader>vwl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
        { buffer = bufnr, desc = '[W]orkspace [L]ist Folders' })

    vim.keymap.set({ 'n', 'x' }, '<leader>vff', function() vim.lsp.buf.format({ async = true }) end,
        { buffer = bufnr, desc = 'Format File current buffer using LSP' })
end)

lsp.ensure_installed({
    -- Replace these with whatever servers you want to install
    'clangd',
    'eslint',
    'eslint',
    'lua_ls',
    'rust_analyzer',
    'stylelint_lsp',
    'tailwindcss',
    'tsserver',
    'volar',
    'omnisharp',
})

local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Configure rust language server
local util = require('lspconfig/util')

lspconfig.rust_analyzer.setup({
    capabilities,
    filetypes = {'rust'},
    root_dir = util.root_pattern('Cargo.toml'),
    settings = {
        ['rust-analyzer'] = {
            cargo = {
                allFeatures = true,
            },
        },
    },
})

-- local rt = require('rust-tools')
--
-- rt.setup({
--   server = {
--     on_attach = lsp.on_attach,
--     capabilities = capabilities,
--   },
-- })

-- Configure lua language server
lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

-- Configure c++, c language server
lspconfig.clangd.setup {
    on_attach = lsp.on_attach,
    capabilities = capabilities,
}

-- Configure c# lsp
local omnisharp_bin = "/home/fdbiondi/.local/share/nvim/mason/packages/omnisharp-mono/omnisharp-mono"
local pid = vim.fn.getpid()

lspconfig.omnisharp.setup({
    -- https://github.com/williamboman/nvim-lsp-installer/issues/479#issuecomment-1128840405
    use_mono = true,

    cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) },
})

-- Configure volar language server
lspconfig.volar.setup {
    on_attach = lsp.on_attach,
    capabilities = capabilities,
}

lsp.setup()

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
    mapping = {
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),

        -- Ctrl+Space to trigger completion menu
        ['<C-Space>'] = cmp.mapping.complete(),

        -- Navigate between snippet placeholder
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    },

    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
    },

    sources = {
        { name = 'path' },                                       -- file paths
        { name = 'luasnip' },                                    -- luasnip source
        { name = 'nvim_lsp',               keyword_length = 1 }, -- from language server
        { name = 'nvim_lsp_signature_help' },                    -- func signature
        { name = 'nvim_lua',               keyword_length = 1 }, -- complete neovim's Lua runtime API such vim.lsp.*
        { name = 'buffer',                 keyword_length = 3 }, -- source current buffer
    },
})
