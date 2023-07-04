-- docs: https://vimdoc.sourceforge.net/htmldoc/pi_netrw.html#netrw

vim.g.netrw_banner = 0;
vim.g.netrw_winsize = 25;
vim.g.netrw_browse_split = 0;
vim.g.netrw_liststyle = 0;
vim.g.netrw_fastbrowse = 0; -- always get fresh directory listings

function NetrwToggle()
    local was_opened = false

    for bufnr = 1, vim.fn.bufnr('$') do
        if (vim.fn.getbufvar(bufnr, "&filetype") == "netrw") then
            vim.cmd('silent exe "bwipeout "' .. bufnr)
            was_opened = true
            break
        end
    end

    if not was_opened then
        vim.cmd.Lexplore('%:p:h')
    end
end

function NetrwOpen()
    vim.g.netrw_chgwin = -1; -- back to default value
    vim.cmd.Explore();
end

function NetrwMapping()
    -- mappings docs: https://gist.github.com/danidiaz/37a69305e2ed3319bfff9631175c5d0f
    local opts = { buffer = true, remap = true }

    -- close window
    vim.keymap.set('n', '<A-a>', vim.cmd.Lexplore, opts)
    vim.keymap.set('n', '<A-A>', vim.cmd.Lexplore, opts)

    -- Better navigation
    vim.keymap.set('n', 'H', 'u', opts)                     -- go back in history
    vim.keymap.set('n', 'h', '-^', opts)                    -- go up a dir
    vim.keymap.set('n', 'l', '<CR>', opts)                  -- go to dir/file
    vim.keymap.set('n', 'L', '<CR><cmd>Lexplore<CR>', opts) -- go to file and close netrw window
    vim.keymap.set('n', 'p', '<CR><C-w>wj', opts)           -- file preview and move to next
    vim.keymap.set('n', 'P', '<CR><C-w>wk', opts)           -- file preview and move to prev

    -- File manipulation
    vim.keymap.set('n', '<A-c>', '%', opts) -- new file
    vim.keymap.set('n', '<A-C>', 'd', opts) -- new directory
    vim.keymap.set('n', '<A-r>', 'R', opts) -- rename
    vim.keymap.set('n', '<A-d>', 'D', opts) -- remove

    -- Toggle dotfiles
    vim.keymap.set('n', '.', 'gh', opts)
end

-- keymaps
vim.keymap.set('n', '<leader>pv', NetrwOpen, { desc = 'Go to Explorer ' });
vim.keymap.set('n', '<A-a>', NetrwToggle, { desc = 'Toggle Explorer', remap = true })
vim.keymap.set('n', '<A-A>', vim.cmd.Lexplore, { desc = 'Toggle Explorer (root)' })

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

autocmd('FileType', {
    callback = NetrwMapping,
    desc = 'Keybindings for netrw',
    group = augroup('ExplorerGroup', { clear = true }),
    pattern = 'netrw',
})

autocmd('VimEnter', {
    callback = function()
        if next(vim.fn.argv()) == nil then
            -- neovim was opened with no args
            NetrwOpen()
        end
    end,
    desc = 'Opens tree on neovim start.',
    group = augroup('OpenExplorerOnEnter', { clear = true }),
    pattern = '*',
})
