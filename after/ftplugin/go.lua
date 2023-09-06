if vim.b.did_ftplugin_after == 1 then
    return
end

vim.b.did_ftplugin_after = 1
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4

vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*.go',
    callback = function()
        vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
    end
})
