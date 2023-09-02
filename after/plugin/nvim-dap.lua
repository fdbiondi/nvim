require("dapui").setup({})

local dap = require("dap")
local dapui = require("dapui")

vim.keymap.set("n", "<F29>", dap.run_last, { desc = "DAP Run Last" })   -- Control F5
vim.keymap.set("n", "<F17>", dap.terminate, { desc = "DAP Terminate" }) -- Shift F5

vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP Continue" })
vim.keymap.set("n", "<F6>", dap.run_to_cursor, { desc = "DAP Run To Cursor" })
vim.keymap.set("n", "<F10>", dap.step_over, { desc = "DAP Step Over" })
vim.keymap.set("n", "<F11>", dap.step_into, { desc = "DAP Step Into" })
vim.keymap.set("n", "<F23>", dap.step_out, { desc = "DAP Step Out" }) -- Shift F11

vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, { desc = "DAP Toggle Breakpoint" })
vim.keymap.set("n", "<F8>", function() dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end,
    { desc = "DAP Set Log Point" })
vim.keymap.set({ "n", "v" }, "<F7>", require("dap.ui.widgets").hover, { desc = "DAP inspect" })

vim.keymap.set("n", "<F13>",
    function()
        local widgets = require("dap.ui.widgets")
        widgets.sidebar(widgets.frames)
    end, { desc = "DAP View Frames" })
vim.keymap.set("n", "<F14>",
    function()
        local widgets = require("dap.ui.widgets")
        widgets.sidebar(widgets.scopes)
    end, { desc = "DAP View Scopes" })

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end
