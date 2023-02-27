local M = {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
    end,
}


function M.config()
    require("nvim-treesitter.configs").setup({
        ensure_installed = {
            "go",
            "html",
            "css",
            "javascript",
            "typescript",
            "lua",
            "vim",
            "svelte",
            "yaml",
            "json",
            "help",
            "python",
            "markdown",
        },
        sync_install = false,
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
    })
end

return M
