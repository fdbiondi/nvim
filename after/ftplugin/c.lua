-- Only do this when not done yet for this buffer
if vim.b.did_ftplugin_after == 1 then
  return
end

vim.b.did_ftplugin_after = 1

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
