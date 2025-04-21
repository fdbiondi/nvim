return {
    {
        "Exafunction/codeium.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
        },
        opts = {},
        config = function()
            require("codeium").setup({
            })
        end
    },

    { 'github/copilot.vim' }
}
