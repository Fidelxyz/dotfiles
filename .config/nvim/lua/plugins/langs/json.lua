return {
    {
        "nvim-treesitter/nvim-treesitter",
        optional = true,
        opts = function()
            require("nvim-treesitter").install({ "json" })
        end,
    },
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = {
            formatters_by_ft = {
                json = { "prettier" },
                jsonc = { "prettier" },
            },
            disable_autoformat_ft = {
                json = true,
                jsonc = true,
            },
        },
    },
}
