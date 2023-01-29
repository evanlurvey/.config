return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		config = {},
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
	{
		"RRethy/vim-illuminate",
		event = "BufEnter",
		config = function()
			require("illuminate").configure({
				delay = 50,
                filetypes_denylist = {
                    'fugitive',
                    'NvimTree'
                }
			})
		end,
	},
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTelescope", "TodoQuickFix" },
		event = "BufEnter",
		config = {},
	},
	-- {
	-- 	"folke/noice.nvim",
	--        event = "VeryLazy",
	-- 	dependencies = {
	-- 		"MunifTanjim/nui.nvim",
	-- 		"rcarriga/nvim-notify",
	-- 	},
	--        config = {},
	-- },
	{
		"j-hui/fidget.nvim",
		event = "VeryLazy",
		config = {},
	},
}
