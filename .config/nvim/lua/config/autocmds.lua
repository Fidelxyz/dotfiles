local utils = require("utils")

vim.api.nvim_create_augroup("CursorLine", {})
vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter" }, {
    group = "CursorLine",
    callback = function()
        if utils.is_buf_editor() then
            vim.wo.cursorline = true
        end
    end,
    desc = "Enable cursorline when entering a window",
})
vim.api.nvim_create_autocmd({ "WinLeave" }, {
    group = "CursorLine",
    callback = function()
        if utils.is_buf_editor() then
            vim.wo.cursorline = false
        end
    end,
    desc = "Disable cursorline when leaving a window",
})

vim.api.nvim_create_augroup("SpellCheck", {})
vim.api.nvim_create_autocmd({ "FileType" }, {
    group = "SpellCheck",
    pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.spellcapcheck = ""
    end,
    desc = "Enable spellcheck for defined filetypes",
})

-- Auto save and load view
vim.api.nvim_create_augroup("AutoView", {})
vim.api.nvim_create_autocmd("BufWinLeave", {
    group = "AutoView",
    command = "silent! mkview",
})
vim.api.nvim_create_autocmd("BufWinEnter", {
    group = "AutoView",
    command = "silent! loadview",
})
vim.opt.viewoptions = "cursor,folds"

vim.api.nvim_create_augroup("Treesitter", {})
vim.api.nvim_create_autocmd("FileType", {
    group = "Treesitter",
    callback = function(args)
        local lang = vim.treesitter.language.get_lang(args.match)
        if not lang then
            return
        end

        if vim.treesitter.query.get(lang, "highlights") then
            vim.treesitter.start(args.buf)
        end

        if vim.treesitter.query.get(lang, "indents") then
            vim.opt_local.indentexpr = 'v:lua.require("nvim-treesitter").indentexpr()'
        end

        -- if vim.treesitter.query.get(lang, "folds") then
        --     vim.opt_local.foldmethod = "expr"
        --     vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        -- end
    end,
})

vim.api.nvim_create_augroup("ColorColumn", {})
vim.api.nvim_create_autocmd("FileType", {
    group = "ColorColumn",
    pattern = { "text" },
    callback = function()
        vim.opt_local.colorcolumn = "80"
    end,
})
vim.api.nvim_create_autocmd("FileType", {
    group = "ColorColumn",
    pattern = { "markdown", "lua" },
    callback = function()
        vim.opt_local.colorcolumn = "120"
    end,
})
