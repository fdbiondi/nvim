return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },
    opts = {
        ignore = function(buf)
            -- Skip scratch/floating buffers such as LSP hover windows.
            return vim.bo[buf].buftype ~= ''
        end,
    },
}
