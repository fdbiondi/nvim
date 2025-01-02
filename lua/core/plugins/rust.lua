return {
    {
        'mrcjkb/rustaceanvim',
        version = '^5', -- Recommended
        lazy = false,   -- This plugin is already lazy
        ft = "rust",

        config = function()
            -- setup debugging
            local this_os = vim.loop.os_uname().sysname;
            local mason_registry = require("mason-registry")
            local codelldb = mason_registry.get_package("codelldb")
            local extension_path = codelldb:get_install_path() .. "/extension/"
            local codelldb_path = extension_path .. "adapter/codelldb"
            local liblldb_path = extension_path .. "lldb/lib/liblldb"

            -- The liblldb extension is .so for linux and .dylib for macOS
            liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")

            local cfg = require('rustaceanvim.config')

            vim.g.rustaceanvim = {
                dap = {
                    adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
                },
            }

            -- https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(via--codelldb)
            -- local dap = require("dap")
            --
            -- dap.adapters.codelldb = {
            --     type = "server",
            --     host = "127.0.0.1",
            --     port = "${port}",
            --     executable = {
            --         command = codelldb_path,
            --         args = { "--port", "${port}" },
            --     }
            -- }
            --
            -- dap.configurations.rust = {
            --     {
            --         name = "Launch file",
            --         type = "codelldb",
            --         request = "launch",
            --         program = function()
            --             return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            --         end,
            --         cwd = "${workspaceFolder}",
            --         stopOnEntry = false,
            --         args = {},
            --     },
            -- }
        end
    },

    {
        'rust-lang/rust.vim',
        ft = "rust",
        init = function()
            vim.g.rustfmt_autosave = 1
        end
    },

    {
        'saecki/crates.nvim',
        ft = { "toml" },
        config = function()
            require("crates").setup {
                completion = {
                    cmp = {
                        enabled = true
                    },
                },
            }
            require('cmp').setup.buffer({
                sources = { { name = "crates" } }
            })
        end
    },
}
