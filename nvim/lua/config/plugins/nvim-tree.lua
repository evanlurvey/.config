return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    tag = "nightly",
    cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile" },
    keys = {
        { "<leader>tt", "<cmd>NvimTreeToggle<CR>" },
        { "<leader>tf", "<cmd>NvimTreeFocus<CR>" },
        { "<leader>t.", "<cmd>NvimTreeFindFile<CR>" },
    },
    config = {},
}
