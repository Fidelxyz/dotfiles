vim.keymap.set("n", "<C-i>", "<C-i>", { noremap = true })

-- Save
vim.keymap.set("n", "<leader>w", function()
    if vim.g.vscode then
        require("vscode").action("workbench.action.files.save")
    else
        vim.api.nvim_command("update")
    end
end, { desc = "Save" })

-- Super Tab
vim.keymap.set("i", "<Tab>", function()
    local utils = require("utils")
    local is_not_vscode = utils.is_not_vscode()

    local suggestion = is_not_vscode and require("copilot.suggestion")
    if suggestion and suggestion.is_visible() then -- Copilot
        suggestion.accept()
        return
    end

    local smart_tab = is_not_vscode and require("smart-tab")
    if smart_tab and not utils.is_blank_line() and smart_tab.smart_tab() then -- Smart tab
        return
    end

    local auto_indent = is_not_vscode and require("utils.auto-indent")
    if auto_indent and auto_indent.check_indent() then -- Auto indent
        return
    end

    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
end, { desc = "Super Tab" })

-- Rename
vim.keymap.set("n", "<leader>r", function()
    local new_name = vim.fn.input("Rename")
    if new_name ~= "" then
        vim.lsp.buf.rename(new_name)
    end
end, { desc = "LSP: Rename" })

-- Diagnostic
vim.keymap.set("n", "<leader>x", "", { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>xs", function()
    vim.diagnostic.open_float({ scope = "cursor" })
end, { desc = "Diagnostics: Show line diagnostics" })
vim.keymap.set("n", "<leader>xt", function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Diagnostics: Toggle" })

-- Move to beginning or end of line
vim.keymap.set({ "n", "v" }, "H", "^", { noremap = true })
vim.keymap.set({ "n", "v" }, "L", "$", { noremap = true })
-- Add new line below
vim.keymap.set("n", "<CR>", "o<Esc>", { noremap = true })
-- Delete a word in insert mode
vim.keymap.set("i", "<C-BS>", "<C-w>", { noremap = true })

-- Delete without yanking
vim.keymap.set("x", "p", function()
    return 'pgv"' .. vim.v.register .. "y`>"
end, { expr = true })
vim.keymap.set("x", "P", function()
    return 'Pgv"' .. vim.v.register .. "y`>"
end, { expr = true })
vim.keymap.set("n", "x", '"_x', { noremap = true })
vim.keymap.set("n", "X", '"_X', { noremap = true })
vim.keymap.set({ "n", "v" }, "c", '"_c', { noremap = true })
vim.keymap.set({ "n", "v" }, "C", '"_C', { noremap = true })
