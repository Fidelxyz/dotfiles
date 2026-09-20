return {
    "nmac427/guess-indent.nvim",

    event = "BufRead",

    opts = {
        on_tab_options = {
            ["expandtab"] = false,
            ["softtabstop"] = 0,
            ["shiftwidth"] = 0,
        },
    },
}
