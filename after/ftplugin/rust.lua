if vim.b.did_ftplugin_after == 1 then
  return
end

vim.b.did_ftplugin_after = 1

-- Don't do comment stuffs when I use o/O
vim.opt_local.formatoptions:remove "o"

vim.keymap.set("n", "<F5>", function()
  if require("dap").session() then
    require("dap").continue()
  else
    R("tj.dap").select_rust_runnable()
  end
end)
