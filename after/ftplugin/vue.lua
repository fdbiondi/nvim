if vim.b.did_ftplugin_after == 1 then
  return
end

vim.b.did_ftplugin_after = 1

vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.expandtab = true
vim.opt_local.softtabstop = 2
vim.opt_local.autoindent = true
vim.opt_local.smartindent = true
vim.opt_local.indentexpr = "nvim_treesitter#indent()"

local ok, conform = pcall(require, "conform")
if ok then
  vim.opt_local.formatexpr = "v:lua.require'conform'.formatexpr()"
  vim.keymap.set({ "n", "x" }, "<leader>ff", function()
    conform.format({
      async = true,
      lsp_format = "fallback",
    })
  end, { buffer = true, desc = "Format Vue file" })
end
