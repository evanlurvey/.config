return {
	{
		"windwp/nvim-autopairs",
		event = "BufEnter",
		config = {
			disable_filetype = { "TelescopePrompt", "NvimTree" },
		},
	},
	{
		"windwp/nvim-ts-autotag",
		event = "BufEnter",
		config = {
			autotag = {
				enable = true,
			},
		},
	},
}
