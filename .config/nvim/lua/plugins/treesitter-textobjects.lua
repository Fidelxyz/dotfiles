return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",

    event = { "BufRead", "BufNewFile" },

    init = function()
        -- Disable entire built-in ftplugin mappings to avoid conflicts.
        -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
        vim.g.no_plugin_maps = true
    end,

    keys = {
        {
            "aa",
            function()
                require("nvim-treesitter-textobjects.select").select_textobject("@parameter.outer", "textobjects")
            end,
            mode = { "x", "o" },
            desc = "Select outer part of a parameter",
        },
        {
            "ia",
            function()
                require("nvim-treesitter-textobjects.select").select_textobject("@parameter.inner", "textobjects")
            end,
            mode = { "x", "o" },
            desc = "Select inner part of a parameter",
        },

        {
            "af",
            function()
                require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
            end,
            mode = { "x", "o" },
            desc = "Select outer part of a function",
        },
        {
            "if",
            function()
                require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
            end,
            mode = { "x", "o" },
            desc = "Select inner part of a function",
        },

        {
            "ma",
            function()
                require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
            end,
            desc = "Swap a parameter with next",
        },
        {
            "mA",
            function()
                require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner")
            end,
            desc = "Swap a parameter with previous",
        },

        {
            "mf",
            function()
                require("nvim-treesitter-textobjects.swap").swap_next("@function.outer")
            end,
            desc = "Swap a function with next",
        },

        {
            "mF",
            function()
                require("nvim-treesitter-textobjects.swap").swap_previous("@function.outer")
            end,
            desc = "Swap a function with previous",
        },
    },

    opts = {
        select = {
            lookahead = true,
        },
    },
}
