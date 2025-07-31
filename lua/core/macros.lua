-- CUSTOM MACROS
local esc = vim.api.nvim_replace_termcodes("<Esc>", true, true, true)

vim.api.nvim_create_augroup("JSlogMacro", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    group = "JSlogMacro",
    pattern = { "javascript", "typescript" }, -- This will trigger for *.js and *.ts files
    callback = function()
        -- "l   yoconsole.log('^[pa: ', ^[pa);^[
        vim.fn.setreg("l", "yoconsole.log('" .. esc .. "pa: ', " .. esc .. "pa);" .. esc);
    end,
})
