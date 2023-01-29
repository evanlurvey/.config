return {
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			{
				"antosha417/nvim-lsp-file-operations",
				config = {},
			},
		},
		tag = "nightly",
		cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile" },
		keys = {
			{ "<leader>tt", "<cmd>NvimTreeToggle<CR>" },
			{ "<leader>tf", "<cmd>NvimTreeFocus<CR>" },
			{ "<leader>t.", "<cmd>NvimTreeFindFile<CR>" },
			{ "<leader>tr", "<cmd>NvimTreeRefresh<CR>" },
		},
		config = {},
	},
}
