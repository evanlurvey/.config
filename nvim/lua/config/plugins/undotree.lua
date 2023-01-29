return {
	"mbbill/undotree",
	cmd = "UndotreeToggle",
	keys = {
		{ "<leader>u", "<cmd>UndotreeToggle<CR>" },
	},
	config = function()
		vim.g.undotree_SetFocusWhenToggle = 1
	end,
}
