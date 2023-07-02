require('telescope').setup {
    defaults = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
        '--hidden',
    },
    extensions = {
        file_browser = {
            -- disables netrw and use telescope-file-browser in its place
            -- hijack_netrw = true,

            -- https://github.com/nvim-telescope/telescope-file-browser.nvim#mappings
            mappings = {
                ["i"] = {
                },
                ["n"] = {
                },
            },
        },
    },
}

require('telescope').load_extension('file_browser')

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = '[F]ind Files' })
vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Git Files' })
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input('Grep > ') })
end, { desc = 'Grep [S]tring' })

vim.keymap.set('n', '<leader>fs', builtin.live_grep, { noremap = true, desc = 'Live Grep' })

vim.keymap.set('n', '<leader>pw', [[:lua require'telescope.builtin'.grep_string({ search = <C-r><C-w> })<CR>]],
    { desc = 'Find [W]ord' })
vim.keymap.set('n', '<leader>vh', builtin.help_tags, { desc = '[H]elp Tags' })

vim.api.nvim_set_keymap('n', '<space>fb', '<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>',
    { noremap = true, desc = '[F]ile [B]rowser' })
