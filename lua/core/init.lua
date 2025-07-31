require('core.remap')
require('core.set')
require('core.lazy_init')

-- If i want to keep doing lsp debugging
-- function restart_htmx_lsp()
--     require("lsp-debug-tools").restart({ expected = {}, name = "htmx-lsp", cmd = { "htmx-lsp", "--level", "DEBUG" }, root_dir = vim.loop.cwd(), });
-- end

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

function R(name)
    require("plenary.reload").reload_module(name)
end

vim.filetype.add({
    extension = {
        templ = 'templ',
    }
})

local HighlightGroup = augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
    group = HighlightGroup,
    pattern = '*',
})

local MyGroup = augroup('MyAwesomeGroup', {})
autocmd('BufWritePre', {
    group = MyGroup,
    pattern = '*',
    command = [[%s/\s\+$//e]],
})

autocmd('LspAttach', {
    group = MyGroup,
    callback = function(e)
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end,
            { buffer = e.buf, desc = "[G]oto [D]efinition" })
        vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end,
            { buffer = e.buf, desc = "[G]oto [D]eclaration" })
        vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end,
            { buffer = e.buf, desc = "[G]oto [R]eferences" })
        vim.keymap.set("n", "gI", function() vim.lsp.buf.implementation() end,
            { buffer = e.buf, desc = "[G]oto [I]mplementation" })
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, { buffer = e.buf, desc = "Hover Documentation" })

        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = e.buf, desc = "[R]e[n]ame" })
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = e.buf, desc = "[C]ode [A]ction" })
        vim.keymap.set("n", "<leader>D", function() vim.lsp.buf.type_definition() end,
            { buffer = e.buf, desc = "Type [D]efinition" })
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end,
            { buffer = e.buf, desc = "Signature Documentation" })

        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end,
            { buffer = e.buf, desc = "Go to previous diagnostic message" })
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end,
            { buffer = e.buf, desc = "Go to next diagnostic message" })

        vim.keymap.set("n", "<leader>vdm", function() vim.diagnostic.open_float({ focusable = true }) end,
            { buffer = e.buf, desc = "Open Floating [D]iagnostic [M]essage" })
        vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references,
            { buffer = e.buf, desc = "[G]oto [R]eferences" })
        vim.keymap.set("n", "<leader>vds", require("telescope.builtin").lsp_document_symbols,
            { buffer = e.buf, desc = "[D]ocument [S]ymbols" })
        -- vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end,
        --     { buffer = e.buf, desc = "[W]orkspace [S]ymbols" })
        vim.keymap.set("n", "<leader>vws", require("telescope.builtin").lsp_dynamic_workspace_symbols,
            { buffer = e.buf, desc = "[W]orkspace [S]ymbols" })
        vim.keymap.set("n", "<leader>vdq", function() vim.diagnostic.setloclist() end,
            { buffer = e.buf, desc = "Open [D]iagnostics [Q]uick List" })
        vim.keymap.set("n", "<leader>vdl", "<cmd>Telescope diagnostics<CR>",
            { buffer = e.buf, desc = "Open telescope [D]iagnostics [L]ist" })
        vim.keymap.set({ "n", "x" }, "<leader>vff", function() vim.lsp.buf.format({ async = true }) end,
            { buffer = e.buf, desc = "[F]ormat [F]ile" })
    end
})

require('core.netrw')

require('core.macros')
