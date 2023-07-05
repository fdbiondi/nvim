if vim.b.did_ftplugin_after == 1 then
  return
end

vim.b.did_ftplugin_after = 1

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.softtabstop = 2
