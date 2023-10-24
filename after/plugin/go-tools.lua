require("go").setup()

local function get_arguments()
    local co = coroutine.running()
    if co then
        return coroutine.create(function()
            local args = {}
            vim.ui.input({ prompt = 'Enter command-line arguments: ' }, function(input)
                args = vim.split(input, " ")
            end)
            coroutine.resume(co, args)
        end)
    else
        local args = {}
        vim.ui.input({ prompt = 'Enter command-line arguments: ' }, function(input)
            args = vim.split(input, " ")
        end)
        return args
    end
end

require('dap-go').setup {
    -- Additional dap configurations can be added.
    -- dap_configurations accepts a list of tables where each entry
    -- represents a dap configuration. For more details do:
    -- :help dap-configuration
    dap_configurations = {
        {
            -- Must be "go" or it will be ignored by the plugin
            type = "go",
            name = "Debug with arguments",
            request = "launch",
            program = "${file}",
            args = get_arguments,
        },
    },
}
