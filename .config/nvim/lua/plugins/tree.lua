return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },

    keys = {
        {
            "<leader>e",
            function()
                require("nvim-tree.api").tree.toggle()
            end,
            desc = "Tree",
        },
    },

    opts = function()
        local custom_filters = vim.tbl_map(function(name)
            return "^" .. vim.fn.escape(name, "\\.^$~[]*") .. "$"
        end, require("utils.ignored-files"))

        return {
            view = {
                float = {
                    enable = true,
                    open_win_config = function()
                        local scr_w = vim.opt.columns:get()
                        local scr_h = vim.opt.lines:get() - 1 -- -1 for statusline
                        local tree_w = 80
                        local tree_h = math.floor(scr_h * 0.75)
                        return {
                            border = "rounded",
                            relative = "editor",
                            width = tree_w,
                            height = tree_h,
                            col = (scr_w - tree_w) / 2 - 1,
                            row = (scr_h - tree_h) / 2 - 1,
                        }
                    end,
                },
            },
            renderer = {
                highlight_git = "all",
            },
            filters = {
                git_ignored = false,
                custom = custom_filters,
            },
        }
    end,

    config = function(_, opts)
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        require("nvim-tree").setup(opts)
    end,
}
