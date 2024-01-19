vim.keymap.set("n", "<leader>ff", vim.lsp.buf.format, { desc = "[F]ormat [F]ile", remap = false })

local Formatter_Group = vim.api.nvim_create_augroup("fmt", { clear = true });
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()

        vim.keymap.set("n", "<leader>ff", "<cmd>Neoformat prettierd<CR>",
            { desc = "Format File using Prettierd", buffer = bufnr, remap = false })
    end,
    group = Formatter_Group,
    pattern = "*.js,*.ts,*.vue,*.css,*.html,*.scss,*.tsx,*.jsx,*.yaml,*.yml,*.json",
})
