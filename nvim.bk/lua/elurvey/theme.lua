require('tokyonight').setup({
    style = 'moon',
    transparent = true,
    on_highlights = function(hl, c)
        hl.LineNr = {
            fg = c.orange,
            bold = true
        }
    end
})
