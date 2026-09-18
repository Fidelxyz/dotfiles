return {
    {
        "nvim-treesitter/nvim-treesitter",
        optional = true,
        opts = function()
            require("nvim-treesitter").install({ "lua", "luadoc", "luap" })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        optional = true,
        opts = function()
            vim.lsp.enable("lua_ls")
            -- vim.lsp.enable("emmylua_ls")
        end,
    },
    {
        "mfussenegger/nvim-lint",
        optional = true,
        opts = {
            linters_by_ft = {
                -- lua = { "luacheck" },
            },
        },
    },
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
            },
        },
    },
}
