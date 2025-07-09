return {
    'sbdchd/neoformat',

    config = function()
        local Formatter_Group = vim.api.nvim_create_augroup("fmt", { clear = true });
        local autocmd = vim.api.nvim_create_autocmd

        autocmd({ "BufNewFile", "BufRead" }, {
            group = Formatter_Group,
            pattern = "*.js,*.ts,*.vue,*.css,*.html,*.scss,*.tsx,*.jsx,*.yaml,*.yml,*.json",

            callback = function()
                local bufnr = vim.api.nvim_get_current_buf()

                vim.keymap.set("n", "<leader>ff", "<cmd>Neoformat prettierd<CR>",
                    { desc = "Format File using Prettierd", buffer = bufnr, remap = false })
            end,
        })

        vim.keymap.set({ "n", "x" }, "<leader>ff", function() vim.lsp.buf.format({ async = true }) end,
            { remap = false, desc = "[F]ormat [F]ile" })
    end
}
