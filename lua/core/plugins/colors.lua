function ColorMyPencils(color)
    color = color or "rose-pine-moon"
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
    {
        "erikbackman/brightburn.vim",
    },

    {
        "ellisonleao/gruvbox.nvim",
        name = "gruvbox",
        opts = {
            terminal_colors = true,     -- add neovim terminal colors
            undercurl = true,
            underline = false,
            bold = true,
            italic = {
                strings = false,
                emphasis = false,
                comments = false,
                operators = false,
                folds = false,
            },
            strikethrough = true,
            invert_selection = false,
            invert_signs = false,
            invert_tabline = false,
            invert_intend_guides = false,
            inverse = true,     -- invert background for search, diffs, statuslines and errors
            contrast = "",      -- can be "hard", "soft" or empty string
            palette_overrides = {},
            overrides = {},
            dim_inactive = false,
            transparent_mode = false,
        }
    },

    {
        "rose-pine/neovim",
        name = "rose-pine",
        opts = {
            disable_background = true,
            styles = {
                italic = false,
            },
        },
        config = function()
            ColorMyPencils();
        end
    },

    {
        'briones-gabriel/darcula-solid.nvim',
        dependencies = 'rktjmp/lush.nvim'
    },
}
