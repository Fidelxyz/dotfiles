return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",

        opts = {
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = false,
                    node_incremental = "v",
                    node_decremental = "V",
                    scope_incremental = false,
                },
            },
        },

        config = function()
            require("nvim-treesitter").install({
                -- Defined in language-specific configs
                "diff",
                "markdown",
                "markdown_inline",
                "nix",
                "printf",
                "query",
                "regex",
                "toml",
                "vim",
                "vimdoc",
                "xml",
            })
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        optional = true,
        opts = {
            ensure_installed = {
                "tree-sitter-cli",
            },
        },
    },
}
