local hooks = require "ibl.hooks"

hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "IndentLineColor", { fg = "#6e6a86" })
end)

require("ibl").setup {
    indent = {
        highlight = { "IndentLineColor" }
    },
}
