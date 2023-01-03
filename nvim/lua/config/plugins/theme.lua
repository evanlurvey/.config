local M = {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 999,
}

function M.config()
    local tokyonight = require("tokyonight")

    tokyonight.setup({
        style = "moon",
        transparent = true,

        on_highlights = function(hl, c)
            hl.LineNr = {
                fg = c.orange,
                bold = true
            }
        end
    })

    tokyonight.load()
end


return M
