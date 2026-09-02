return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,

    opts = {
        flavour = "mocha",
        auto_integrations = true,

        ---@module 'catppuccin.colors'
        ---@param colors CtpColors<string>
        ---Style Guide: https://github.com/catppuccin/catppuccin/blob/main/docs/style-guide.md
        custom_highlights = function(colors)
            return {
                -- Diffview
                -- https://github.com/sindrets/diffview.nvim/blob/main/lua/diffview/hl.lua
                DiffviewDiffDelete = { fg = colors.surface0 },
                DiffviewDiffDeleteDim = { fg = colors.surface0 },

                -- Hunk
                HunkTreeFileAdded = { fg = colors.green },
                HunkTreeFileDeleted = { fg = colors.red },
                HunkTreeFileModified = { fg = colors.blue },
                HunkTreeDirIcon = { fg = colors.yellow },
                HunkTreeSelectionIcon = { fg = colors.overlay2 },
            }
        end,
    },
    config = function(_, opts)
        require("catppuccin").setup(opts)
        vim.cmd.colorscheme("catppuccin")
    end,
}
