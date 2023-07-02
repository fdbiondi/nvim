require('core.remap')
require('core.set')

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

function R(name)
    require("plenary.reload").reload_module(name)
end

local highlight_group = augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
    group = highlight_group,
    pattern = '*',
})

local fb_group = augroup('FBiondi', {})
autocmd('BufWritePre', {
    group = fb_group,
    pattern = '*',
    command = [[%s/\s\+$//e]],
})

require('core.netrw')
