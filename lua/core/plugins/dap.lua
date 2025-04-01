local js_based_languages = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' }

return {
    {
        'mfussenegger/nvim-dap',

        dependencies = {
            -- {
            --     'rcarriga/nvim-dap-ui',
            --     keys = {
            --         { '<leader>du', function() require('dapui').toggle({}) end, desc = desc('Dap UI') },
            --         { '<leader>de', function() require('dapui').eval() end,     desc = desc('Eval'),  mode = { 'n', 'v' } },
            --     },
            --     opts = {},
            -- },
            -- { 'theHamsta/nvim-dap-virtual-text', opts = {} },

            -- vscode-js-debug adapter
            {
                'microsoft/vscode-js-debug',
                -- After install, build it and rename the dist directory to out
                build =
                'npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out',
                version = '1.*',
            },

            {
                'mxsdev/nvim-dap-vscode-js',
                opts = {
                    debugger_path = vim.fn.resolve(vim.fn.stdpath('data') .. '/lazy/vscode-js-debug'),
                    adapters = { 'chrome', 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'pwa-extensionHost', 'node-terminal' },
                }
            },

        },

        config = function()
            local dap, dapui = require("dap"), require("dapui")

            vim.keymap.set("n", "<F4>", dap.repl.open, { desc = "DAP Open Repl" })
            vim.keymap.set("n", "<F29>", dap.run_last, { desc = "DAP Run Last (Ctrl+F5)" })    -- Control F5
            vim.keymap.set("n", "<F17>", dap.terminate, { desc = "DAP Terminate (Shift+F5)" }) -- Shift F5

            vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP Continue" })
            vim.keymap.set("n", "<F6>", dap.run_to_cursor, { desc = "DAP Run To Cursor" })
            vim.keymap.set("n", "<F10>", dap.step_over, { desc = "DAP Step Over" })
            vim.keymap.set("n", "<F11>", dap.step_into, { desc = "DAP Step Into" })
            vim.keymap.set("n", "<F23>", dap.step_out, { desc = "DAP Step Out (Shift+F11)" }) -- Shift F11

            vim.keymap.set({ "n", "v" }, "<F8>", require("dap.ui.widgets").hover, { desc = "DAP Inspect" })
            vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, { desc = "DAP Toggle Breakpoint" })
            vim.keymap.set("n", "<leader>B", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
                { desc = "DAP Breakpoint Condition" })
            vim.keymap.set("n", "<leader>lp",
                function() dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end,
                { desc = "DAP Set Log Point" })

            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end


            -- local icons = require('utils.icons')

            vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })

            -- for name, sign in pairs(icons.dap) do
            --     sign = type(sign) == 'table' and sign or { sign }
            --     vim.fn.sign_define(
            --         'Dap' .. name,
            --         { text = sign[1], texthl = sign[2] or 'DiagnosticInfo', linehl = sign[3], numhl = sign[3] }
            --     )
            -- end

            for _, language in ipairs(js_based_languages) do
                dap.configurations[language] = {
                    {
                        type = "pwa-node",
                        request = "launch",
                        name = "Next.js: debug server-side",
                        skipFiles = { "<node_internals>/**" },
                        cwd = "${workspaceFolder}",
                        runtimeExecutable = "npm",
                        runtimeArgs = { "run-script", "dev" }
                    },
                    -- Debug single nodejs files
                    {
                        type = 'pwa-node',
                        request = 'launch',
                        name = 'Launch file',
                        program = '${file}',
                        cwd = vim.fn.getcwd(),
                        sourceMaps = true,
                    },
                    -- Debug nodejs processes (make sure to add --inspect when you run the process)
                    {
                        type = 'pwa-node',
                        request = 'attach',
                        name = 'Attach',
                        processId = require('dap.utils').pick_process,
                        cwd = vim.fn.getcwd(),
                        sourceMaps = true,
                    },
                    -- Debug web applications (client side)
                    {
                        type = 'pwa-chrome',
                        request = 'launch',
                        name = 'Launch & Debug Chrome',
                        url = function()
                            local co = coroutine.running()
                            return coroutine.create(function()
                                vim.ui.input({ prompt = 'Enter URL: ', default = 'http://localhost:3000' }, function(url)
                                    if url == nil or url == '' then
                                        return
                                    else
                                        coroutine.resume(co, url)
                                    end
                                end)
                            end)
                        end,
                        webRoot = vim.fn.getcwd(),
                        protocol = 'inspector',
                        sourceMaps = true,
                        userDataDir = false,
                    },
                    {
                        type = 'pwa-chrome',
                        request = 'attach',
                        name = 'Attach Program (pwa-chrome = { port: 9222 })',
                        program = '${file}',
                        cwd = vim.fn.getcwd(),
                        sourceMaps = true,
                        protocol = 'inspector',
                        port = 9222,
                        webRoot = '${workspaceFolder}',
                    },
                    {
                        type = 'chrome',
                        request = 'attach',
                        name = 'Attach Program (chrome = { port: 9222 })',
                        program = '${file}',
                        cwd = vim.fn.getcwd(),
                        sourceMaps = true,
                        protocol = 'inspector',
                        port = 9222,
                        webRoot = '${workspaceFolder}'
                    },
                    -- Divider for the launch.json derived configs
                    {
                        name = '----- ↓ launch.json configs (if available) ↓ -----',
                        type = '',
                        request = 'launch',
                    },
                }
            end

            dap.adapters.chrome = {
                type = 'executable',
                command = 'node',
                args = { vim.fn.resolve(vim.fn.stdpath('data') .. '/lazy/vscode-js-debug') }
            }
        end,
    },

    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        opts = {}
    },

    { "theHamsta/nvim-dap-virtual-text", dependencies = { "mfussenegger/nvim-dap" } }
}
