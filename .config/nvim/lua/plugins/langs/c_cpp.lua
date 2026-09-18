return {
    {
        "nvim-treesitter/nvim-treesitter",
        optional = true,
        opts = function()
            require("nvim-treesitter").install({ "c", "cpp", "cmake" })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        optional = true,
        opts = function()
            vim.lsp.config("clangd", {
                cmd = { "clangd", "--clang-tidy" },
            })
            vim.lsp.enable("clangd")
        end,
    },
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = {
            formatters_by_ft = {
                cpp = { "clang-format" },
                c = { "clang-format" },
                cmake = { "cmake_format" },
            },
        },
    },
    {
        "mfussenegger/nvim-dap",
        optional = true,
        opts = function()
            local dap = require("dap")

            dap.adapters.codelldb = {
                type = "executable",
                command = "codelldb",
            }

            dap.configurations.cpp = {
                {
                    name = "Launch file",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        local pickers = require("telescope.pickers")
                        local finders = require("telescope.finders")
                        local conf = require("telescope.config").values
                        local actions = require("telescope.actions")
                        local action_state = require("telescope.actions.state")

                        return coroutine.create(function(coro)
                            local opts = {}
                            pickers
                                .new(opts, {
                                    prompt_title = "Path to executable",
                                    finder = finders.new_oneshot_job(
                                        { "fd", "--hidden", "--no-ignore", "--type", "x" },
                                        {}
                                    ),
                                    sorter = conf.generic_sorter(opts),
                                    attach_mappings = function(buffer_number)
                                        actions.select_default:replace(function()
                                            actions.close(buffer_number)
                                            coroutine.resume(coro, action_state.get_selected_entry()[1])
                                        end)
                                        return true
                                    end,
                                })
                                :find()
                        end)
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                },
            }
        end,
    },
}
