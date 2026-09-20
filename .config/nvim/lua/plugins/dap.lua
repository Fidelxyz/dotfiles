---@param config {type?:string, args?:string[]|fun():string[]?}
local function get_args(config)
    local args = type(config.args) == "function" and (config.args() or {}) or config.args or {} --[[@as string[] | string ]]
    local args_str = type(args) == "table" and table.concat(args, " ") or args --[[@as string]]

    config = vim.deepcopy(config)
    ---@cast args string[]
    config.args = function()
        local new_args = vim.fn.expand(vim.fn.input("Run with args: ", args_str)) --[[@as string]]
        if config.type and config.type == "java" then
            ---@diagnostic disable-next-line: return-type-mismatch
            return new_args
        end
        return require("dap.utils").splitstr(new_args)
    end
    return config
end

return {
    {
        "mfussenegger/nvim-dap",
        dependencies = { "theHamsta/nvim-dap-virtual-text" },

        -- stylua: ignore
        keys = {
            { "<leader>d",  "",                                                                                   desc = "Debugging" },
            { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Debugging: Breakpoint Condition" },
            { "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "Debugging: Toggle Breakpoint" },
            { "<leader>dc", function() require("dap").continue() end,                                             desc = "Debugging: Run/Continue" },
            { "<leader>da", function() require("dap").continue({ before = get_args }) end,                        desc = "Debugging: Run with Args" },
            { "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "Debugging: Run to Cursor" },
            { "<leader>dg", function() require("dap").goto_() end,                                                desc = "Debugging: Go to Line (No Execute)" },
            { "<leader>di", function() require("dap").step_into() end,                                            desc = "Debugging: Step Into" },
            { "<leader>dj", function() require("dap").down() end,                                                 desc = "Debugging: Down" },
            { "<leader>dk", function() require("dap").up() end,                                                   desc = "Debugging: Up" },
            { "<leader>dl", function() require("dap").run_last() end,                                             desc = "Debugging: Run Last" },
            { "<leader>do", function() require("dap").step_out() end,                                             desc = "Debugging: Step Out" },
            { "<leader>dO", function() require("dap").step_over() end,                                            desc = "Debugging: Step Over" },
            { "<leader>dP", function() require("dap").pause() end,                                                desc = "Debugging: Pause" },
            { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "Debugging: Toggle REPL" },
            { "<leader>ds", function() require("dap").session() end,                                              desc = "Debugging: Session" },
            { "<leader>dt", function() require("dap").terminate() end,                                            desc = "Debugging: Terminate" },
            { "<leader>dw", function() require("dap.ui.widgets").hover() end,                                     desc = "Debugging: Widgets" },
        },
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },

        -- stylua: ignore
        keys = {
            { "<leader>du", function() require("dapui").toggle({}) end, desc = "Debugging: Dap UI" },
            { "<leader>de", function() require("dapui").eval() end,     desc = "Debugging: Eval", mode = {"n", "v"} },
        },

        opts = {},
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        lazy = true,
        opts = {},
    },
}
