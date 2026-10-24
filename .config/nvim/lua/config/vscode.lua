if not vim.g.vscode then
    return {}
end

local enabled_plugins = {
    "conform.nvim",
    "flash.nvim",
    "guess-indent",
    "nvim-toggler",
    "nvim-treesitter",
    "nvim-treesitter-textobjects",
    "visual-surround.nvim",
}

local config = require("lazy.core.config")
config.options.checker.enabled = false
config.options.change_detection.enabled = false
config.options.defaults.cond = function(plugin)
    return vim.tbl_contains(enabled_plugins, plugin.name)
end

return {}
