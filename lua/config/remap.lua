vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = 'Move lines down when selected' })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = 'Move lines up when selected' })

vim.keymap.set("n", "J", "mzJ`z", { desc = 'Appends line below to current line' })
vim.keymap.set("n", "<leader>J", "f<Space>r<CR>", { desc = 'Move content after space to new line' })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = 'Half page jump down' })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = 'Half page jump up' })
vim.keymap.set("n", "n", "nzzzv", { desc = 'Keep next search term at middle of screen' })
vim.keymap.set("n", "N", "Nzzzv", { desc = 'Keep next search term at middle of screen' })

-- paste and delete text without losing current paste buffer (void register)
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = 'Paste without losing current paste buffer' })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = 'Delete without losing current paste buffer' })

-- copy text to system clipboard (plus register)
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = 'Copy to system clipboard' })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = 'Copy line to system clipboard' })

-- copy filename to clipboard
vim.keymap.set("n", "<leader>cn", "<cmd>let @+ = expand('%:t')<CR>", { desc = '[C]opy File[N]ame to clipboard' })
vim.keymap.set("n", "<leader>cr", "<cmd>let @+ = expand('%')<CR>", { desc = '[C]opy [R]elative filepath to clipboard' })
vim.keymap.set("n", "<leader>cf", "<cmd>let @+ = expand('%:p')<CR>", { desc = '[C]opy [F]ull filepath to clipboard' })
vim.keymap.set("n", "<leader>cd", "<cmd>let @+ = expand('%:h')<CR>", { desc = '[C]opy [D]irectory to clipboard' })

-- map esc behavior to ctrl+c while in vertical edit mode
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- quickfix navigation
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- search and replace on file
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = '[S]earch and replace' })
-- make file an executable file
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = 'Make file e[x]ecutable' })

vim.keymap.set("n", "<leader><leader>", function() vim.cmd("so") end)
