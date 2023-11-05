return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        local tokyonight = require("tokyonight")

        tokyonight.setup({
            style = "moon",
            transparent = true,
            on_highlights = function(hl, c)
                hl.LineNr = { fg = c.orange }
            end,
        })

        tokyonight.load()
    end,
}

