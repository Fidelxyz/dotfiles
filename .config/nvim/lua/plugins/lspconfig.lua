return {
    "neovim/nvim-lspconfig",

    event = { "BufReadPre", "BufNewFile" },

    keys = {
        {
            "<C-CR>",
            function()
                vim.lsp.buf.code_action()
            end,
            desc = "Code action",
        },
    },

    config = function()
        vim.lsp.log.set_level("warn")
    end,
}
