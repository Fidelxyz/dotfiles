return {
    {
        "nvim-treesitter/nvim-treesitter",
        optional = true,
        opts = function()
            require("nvim-treesitter").install({ "css", "html", "javascript", "jsdoc", "typescript", "vue" })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        optional = true,
        opts = function()
            -- vue
            local vue_language_server_path = vim.fn.stdpath("data")
                .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"
            local vue_plugin = {
                name = "@vue/typescript-plugin",
                location = vue_language_server_path,
                languages = { "vue" },
                confignamespace = "typescript",
            }
            vim.lsp.config("vtsls", {
                settings = {
                    vtsls = {
                        tsserver = {
                            globalplugins = {
                                vue_plugin,
                            },
                        },
                    },
                    typescript = {
                        inlayhints = {
                            parameternames = { enabled = "all" },
                            parametertypes = { enabled = true },
                            variabletypes = { enabled = true },
                            propertydeclarationtypes = { enabled = true },
                            functionlikereturntypes = { enabled = true },
                            enummembervalues = { enabled = true },
                        },
                    },
                },
                filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
            })
            vim.lsp.config("vue_ls", {
                settings = {
                    typescript = {
                        inlayhints = {
                            enummembervalues = { enabled = true },
                            functionlikereturntypes = { enabled = true },
                            propertydeclarationtypes = { enabled = true },
                            parametertypes = {
                                enabled = true,
                                suppresswhenargumentmatchesname = true,
                            },
                            variabletypes = { enabled = true },
                        },
                    },
                    javascript = {
                        inlayhints = {
                            enummembervalues = { enabled = true },
                            functionlikereturntypes = { enabled = true },
                            propertydeclarationtypes = { enabled = true },
                            parametertypes = {
                                enabled = true,
                                suppresswhenargumentmatchesname = true,
                            },
                            variabletypes = { enabled = true },
                        },
                    },
                    vue = {
                        inlayhints = {
                            destructuredprops = true,
                            missingprops = true,
                            inlinehandlerleading = true,
                            optionswrapper = true,
                            vbindshorthand = true,
                        },
                    },
                },
            })
            vim.lsp.enable({ "vtsls", "vue_ls" })
            vim.lsp.enable("tailwindcss")
        end,
    },
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = {
            formatters_by_ft = {
                javascript = { "prettier", "biome-organize-imports" },
                typescript = { "prettier", "biome-organize-imports" },
                vue = { "prettier", "biome-organize-imports" },
            },
        },
    },
}
