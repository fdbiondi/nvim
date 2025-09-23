return {
    "mistricky/codesnap.nvim",
    build = "make",

    -- keys = {
    --     { "<leader>cc", "<cmd>CodeSnap<cr>", mode = "x", desc = "Save selected code snapshot into clipboard" },
    --     { "<leader>cs", "<cmd>CodeSnapSave<cr>", mode = "x", desc = "Save selected code snapshot in ~/Documents" },
    -- },

    opts = {
        save_path = "~/Documents",
        has_breadcrumbs = true,
        has_line_number = true,
        bg_color = "#535c68",
        bg_x_padding = 40,
        bg_y_padding = 40,
        bg_padding = nil,
        watermark = ""
    },
}
