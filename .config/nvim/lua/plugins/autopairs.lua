return {
    "windwp/nvim-autopairs",

    event = "InsertEnter",

    opts = {},
    config = function(_, opts)
        local autopairs = require("nvim-autopairs")
        local Rule = require("nvim-autopairs.rule")
        local cond = require("nvim-autopairs.conds")
        local ts_cond = require("nvim-autopairs.ts-conds")

        autopairs.setup(opts)

        local rule_pair_inside_surrounding = function(a1, ins, a2, filetype)
            return Rule(ins, ins, filetype)
                :with_pair(function(o)
                    return a1 .. a2 == o.line:sub(o.col - #a1, o.col + #a2 - 1)
                end)
                :with_move(cond.none())
                -- :with_cr(cond.none())
                :with_del(function(o)
                    local col = vim.api.nvim_win_get_cursor(0)[2]
                    return a1 .. ins .. ins .. a2 == o.line:sub(col - #a1 - #ins + 1, col + #ins + #a2) -- insert only works for #ins == 1 anyway
                end)
        end

        autopairs.add_rules({
            Rule("$", "$", "typst"),
            Rule("(", ")", "typst"),
            Rule("*", "*", "typst"):with_pair(ts_cond.is_ts_node({ "text", "parbreak", "item", "heading" })),
            Rule("'", "'", "typst"):with_pair(ts_cond.is_ts_node({ "text", "parbreak", "item", "heading" })),
            -- Add spaces between parentheses
            rule_pair_inside_surrounding("(", " ", ")", "typst"),
            -- Add spaces between math equation "$"
            rule_pair_inside_surrounding("$", " ", "$", "typst"),
        })
    end,
}
