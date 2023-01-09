return {
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        config = {}
    },
   {
       "akinsho/bufferline.nvim",
       event = "VeryLazy",
       config = {
           options = {
               diagnostics = "nvim_lsp",
           },
       },
       -- keys = {
       --     {"L", "<cmd>BufferLineCycleNext<CR>", desc = "Switches to the next buffer to the right" },
       --     {"H", "<cmd>BufferLineCyclePrev<CR>", desc = "Switches to the prev buffer to the left" }
       -- }
   },
}
