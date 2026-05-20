return {
    "mistricky/codesnap.nvim",
    config = function()
        local module = require("codesnap.module")
        local fetch = require("codesnap.fetch")

        module.load_generator = function(_)
            if module.generator ~= nil then
                return module.generator
            end

            local lib_path = fetch.ensure_lib()
            local loader, err = package.loadlib(lib_path, "luaopen_generator")

            if not loader then
                error(err)
            end

            module.generator = loader()
            if module.generator.parse_code_theme == nil then
                module.generator.parse_code_theme = function(theme)
                    return theme
                end
            end
            if module.generator.copy == nil and module.generator.copy_into_clipboard ~= nil then
                module.generator.copy = module.generator.copy_into_clipboard
            end
            package.loaded.generator = module.generator

            return module.generator
        end

        require("codesnap").setup({
            save_path = "~/Documents",
            show_line_number = true,
            snapshot_config = {
                watermark = {
                    content = "",
                },
                code_config = {
                    breadcrumbs = {
                        enable = true,
                    },
                },
                window = {
                    margin = {
                        x = 40,
                        y = 40,
                    },
                },
                background = "#535c68",
            },
        })
    end,
}
