vim.g.zig_fmt_parse_errors = 0
vim.g.zig_fmt_autosave = 0

return {
    -- cmd = {
    -- },
    filetypes = {
        "zig",
    },
    root_markers = {
        ".git", "build.zig", "zls.json"
    },
    settings = {
        zls = {
            enable_inlay_hints = true,
            enable_snippets = true,
            warn_style = true,
        },
    },
}
