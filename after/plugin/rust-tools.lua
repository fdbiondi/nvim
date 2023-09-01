-- https://github.com/simrat39/rust-tools.nvim/wiki/Debugging
local this_os = vim.loop.os_uname().sysname;
local mason_registry = require("mason-registry")

local codelldb = mason_registry.get_package("codelldb")
local extension_path = codelldb:get_install_path() .. "/extension/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb"

-- The liblldb extension is .so for linux and .dylib for macOS
liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")

-- Configure rust language server -> https://github.com/mfussenegger/nvim-dap/wiki/Extensions
local rt = require("rust-tools")

rt.setup({
    server = {
        on_attach = function(_, bufnr)
            -- Hover actions
            vim.keymap.set("n", "<leader>k", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<leader>A", rt.code_action_group.code_action_group, { buffer = bufnr })
        end,
        capabilities = require("cmp_nvim_lsp").default_capabilities()
    },

    -- debugging stuff
    dap = {
        adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
    },

    tools = {
        hover_actions = {
            auto_focus = true,
        }
    }
})

-- require("dap").adapters.codelldb = {
--     type = "server",
--     host = "127.0.0.1",
--     port = "${port}",
--     executable = {
--         command = codelldb_path,
--         args = { "--port", "${port}" },
--     }
-- }
--
-- require("dap").configurations.rust = {
--     {
--         name = "Launch",
--         type = "lldb",
--         request = "launch",
--         program = function()
--             return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
--         end,
--         cwd = "${workspaceFolder}",
--         stopOnEntry = false,
--         args = {},
--     },
-- }
