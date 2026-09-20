return {
    "nguyenvukhang/nvim-toggler",

    keys = {
        {
            "<leader>i",
            function()
                require("nvim-toggler").toggle()
            end,
            desc = "Toggle",
        },
    },

    opts = {},
}
