
return {
    "nvim-telescope/telescope.nvim",
    cmd = { "Telescope" },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    keys = {
        { "<leader>pf", "<cmd>Telescope find_files hidden=true<CR>"},
    },
    config = {
        -- TODO: I would like to get hidden working by default instead of in the keymaps
        -- defaults = {
        --     vimgrep_arguments = {
        --         "rg",
        --         "--color=never",
        --         "--no-heading",
        --         "--with-filename",
        --         "--line-number",
        --         "--column",
        --         "--smart-case",
        --         "--hidden"
        --     }
        -- }

    }
}
