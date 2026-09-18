return {
    "NStefan002/visual-surround.nvim",

    event = "BufEnter",

    keys = {
        {
            "<C-b>",
            function()
                local filetype = vim.bo.filetype
                local surround = require("visual-surround")
                if filetype == "markdown" then
                    surround.surround("**")
                elseif filetype == "typst" then
                    surround.surround("*")
                end
            end,
            mode = "v",
            ft = { "typst", "markdown" },
        },
    },

    opts = {
        surround_chars = { "{", "}", "[", "]", "(", ")", "'", '"', "`" },
        enable_wrapped_deletion = true,
    },
}
