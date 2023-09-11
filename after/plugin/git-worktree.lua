require("git-worktree").setup()
require("telescope").load_extension("git_worktree")

vim.keymap.set("n", "<leader>gws", "<cmd>Telescope git_worktree git_worktrees<CR>", { desc = "[G]it [W]orktree[s]" })
vim.keymap.set("n", "<leader>gwc", "<cmd>Telescope git_worktree create_git_worktree<CR>", { desc = "[G]it [W]orktree [C]reate" })
