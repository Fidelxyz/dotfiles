return {
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = {
            formatters = {
                oxfmt_markdown = {
                    inherit = "oxfmt",
                    prepend_args = {
                        "--config",
                        vim.fn.stdpath("config") .. "/lua/plugins/langs/markdown/.oxfmtrc.json",
                    },
                },
            },
            formatters_by_ft = {
                markdown = { "oxfmt_markdown" },
            },
            disable_autoformat_ft = {
                markdown = true,
            },
        },
    },
}
