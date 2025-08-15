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
        "vague2k/vague.nvim",
        lazy = false,    -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other plugins
        config = function()
            -- NOTE: you do not need to call setup if you don't want to.
            require("vague").setup({
                -- optional configuration here
            })
            vim.cmd("colorscheme vague")
        end
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
