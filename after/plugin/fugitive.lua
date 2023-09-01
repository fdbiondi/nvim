vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "[G]it [S]tatus" })

vim.keymap.set("n", "gh", "<cmd>diffget //2<CR>", { desc = "Git Diff get left side" })
vim.keymap.set("n", "gl", "<cmd>diffget //3<CR>", { desc = "Git Diff get right side" })

local FugitiveGroup = vim.api.nvim_create_augroup("FugitiveGroup", {})
vim.api.nvim_create_autocmd("BufWinEnter", {
    callback = function()
        if vim.bo.ft ~= "fugitive" then
            return
        end

        local bufnr = vim.api.nvim_get_current_buf()
        local opts = { buffer = bufnr, remap = false }

        vim.keymap.set("n", "<leader>p", function()
            vim.cmd.Git("push --no-verify")
        end, opts)

        -- rebase always
        vim.keymap.set("n", "<leader>P", function()
            vim.cmd.Git("pull --rebase")
        end, opts)

        vim.keymap.set("n", "<leader>t", ":Git push -u --no-verify origin ", opts);
    end,
    group = FugitiveGroup,
    pattern = "*",
})
