require("dapui").setup({})

local dap = require("dap")
local dapui = require("dapui")

vim.keymap.set("n", "<F3>", function() dapui.float_element("breakpoints") end, { desc = "DAP List Breakpoints" })
vim.keymap.set("n", "<F5>", function() dap.continue() end, { desc = "DAP Continue" })
vim.keymap.set("n", "<F10>", function() dap.step_over() end, { desc = "DAP Step Over" })
vim.keymap.set("n", "<F11>", function() dap.step_into() end, { desc = "DAP Step Into" })
vim.keymap.set("n", "<F12>", function() dap.step_out() end, { desc = "DAP Step Out" })
vim.keymap.set("n", "<Leader>b", function() dap.toggle_breakpoint() end, { desc = "DAP Toggle Breakpoint" })
vim.keymap.set("n", "<Leader>B", function() dap.set_breakpoint() end, { desc = "DAP Set Breakpoint" })
vim.keymap.set("n", "<Leader>lp", function() dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end,
    { desc = "DAP Set Log Point" })
vim.keymap.set("n", "<Leader>dr", function() dap.repl.open() end)
vim.keymap.set("n", "<Leader>dl", function() dap.run_last() end, { desc = "DAP Run Last" })

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end
