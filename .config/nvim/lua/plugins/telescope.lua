return {
    {
        "nvim-telescope/telescope.nvim",
        version = "*",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },

        cmd = "Telescope",

        -- stylua: ignore
        keys = {
            { "<C-Space>", function() require("telescope.builtin").find_files() end, desc = "Telescope: find files" },
            { "<leader>f", "", desc = "Telescope" },
            { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Telescope: find files" },
            { "<leader>fg", function() require("telescope.builtin").live_grep() end, desc = "Telescope: live grep" },
            { "<leader>fb", function() require("telescope.builtin").buffers({ initial_mode = "normal" }) end, desc = "Telescope: buffers" },
            { "<leader>fh", function() require("telescope.builtin").help_tags() end, desc = "Telescope: help tags" },
            { "<leader>fr", function() require("telescope.builtin").lsp_references({ initial_mode = "normal" }) end, desc = "Telescope: LSP references" },
            { "<leader>fs", function() require("telescope.builtin").lsp_workspace_symbols() end, desc = "Telescope: LSP symbols" },
            { "<leader>fd", function() require("telescope.builtin").lsp_document_symbols() end, desc = "Telescope: LSP document symbols" },
            { "<leader>fk", function() require("telescope.builtin").keymaps() end, desc = "Telescope: keymaps" },
            { "<leader>fl", function() require("telescope.builtin").highlights() end, desc = "Telescope: highlights" },
            { "<leader>fp", function() require("telescope.builtin").resume() end, desc = "Telescope: resume" },
        },

        opts = function()
            local telescope_config = require("telescope.config")

            -- Clone the default Telescope configuration
            local vimgrep_arguments = { unpack(telescope_config.values.vimgrep_arguments) }

            -- I want to search in hidden/dot files.
            table.insert(vimgrep_arguments, "--hidden")
            -- I don't want to search in the `.git` directory.
            table.insert(vimgrep_arguments, "--glob")
            table.insert(vimgrep_arguments, "!**/.git/*")
            table.insert(vimgrep_arguments, "--glob")
            table.insert(vimgrep_arguments, "!**/.jj/*")

            return {
                defaults = {
                    -- `hidden = true` is not supported in text grep commands.
                    vimgrep_arguments = vimgrep_arguments,
                },
                pickers = {
                    find_files = {
                        -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
                        -- find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
                        find_command = {
                            "fd",
                            "--type",
                            "f",
                            "--color",
                            "never",
                            "--hidden",
                            "--no-ignore-vcs",
                            "--exclude",
                            ".git",
                            "--exclude",
                            ".jj",
                        },
                        live_grep = {
                            additional_args = {
                                "--hidden",
                                "--glob",
                                "!.git",
                                "--glob",
                                "!.jj",
                                "--no-ignore-vcs",
                            },
                        },
                        grep_string = {
                            additional_args = {
                                "--hidden",
                                "--glob",
                                "!.git",
                                "--glob",
                                "!.jj",
                                "--no-ignore-vcs",
                            },
                        },
                    },
                },
            }
        end,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",

        event = { "BufReadPre", "BufNewFile" },

        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown(),
                    },
                },
            })
            require("telescope").load_extension("ui-select")
        end,
    },
}
