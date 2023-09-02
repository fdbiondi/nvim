if vim.b.did_ftplugin_after == 1 then
  return
end

vim.b.did_ftplugin_after = 1

-- Don't do comment stuffs when I use o/O
vim.opt_local.formatoptions:remove "o"
