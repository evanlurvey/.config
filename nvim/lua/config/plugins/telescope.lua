local M = {
    "nvim-telescope/telescope.nvim",
    cmd = { "Telescope" },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    keys = {
        { "<leader>pf", function() require("telescope.builtin").find_files() end },
    },
}

function M.config()
    local telescope = require("telescope")

    telescope.setup({
    })

end


return M

