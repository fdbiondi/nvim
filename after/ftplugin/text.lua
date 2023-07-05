if vim.b.did_ftplugin_after == 1 then
  return
end

vim.b.did_ftplugin_after = 1

vim.opt.colorcolumn = "100"
vim.opt.autoindent = true
vim.opt.linebreak = true
