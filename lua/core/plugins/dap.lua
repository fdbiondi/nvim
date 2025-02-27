return {
    {
        'mfussenegger/nvim-dap',
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
        end
    },

    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        opts = {}
    },

    { "theHamsta/nvim-dap-virtual-text", dependencies = { "mfussenegger/nvim-dap" } }
}
