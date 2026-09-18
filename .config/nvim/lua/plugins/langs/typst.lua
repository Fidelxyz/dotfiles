return {
    {
        "nvim-treesitter/nvim-treesitter",
        optional = true,
        opts = function()
            require("nvim-treesitter").install({ "typst" })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        optional = true,
        opts = function()
            vim.lsp.config("tinymist", {
                settings = {
                    formatterMode = "typstyle",
                    exportPdf = "onType",
                },
            })
            vim.lsp.enable("tinymist")
        end,
    },

    -- Extra plugins
    {
        "chomosuke/typst-preview.nvim",
        ft = "typst",
        version = "1.*",

        opts = {},
    },
}
