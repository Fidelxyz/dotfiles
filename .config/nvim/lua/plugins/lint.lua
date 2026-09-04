return {
    "mfussenegger/nvim-lint",

    event = { "BufReadPre" },

    opts = {
        linters_by_ft = {
            -- defined in language-specific configs
        },
    },

    config = function(_, opts)
        local lint = require("lint")

        lint.linters_by_ft = opts.linters_by_ft

        vim.api.nvim_create_autocmd({ "BufRead", "BufWritePost" }, {
            callback = function()
                lint.try_lint()
            end,
        })
    end,
}
