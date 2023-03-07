-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#go-using-delve-directly
return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{
				"rcarriga/nvim-dap-ui",
				config = function()
					require("dapui").setup()
				end,
			},
			{
				"leoluz/nvim-dap-go",
				keys = {
					{
						"<leader>dt",
						function()
							require("dap-go").debug_test()
						end,
						desc = "dap: GoLang debug test",
					},
					{
						"<leader>dlt",
						function()
							require("dap-go").debug_test()
						end,
						desc = "dap: GoLang debug last ran test",
					},
				},
				config = {
					dap_configurations = {
						{
							type = "go",
							name = "Attach remote",
							mode = "remote",
							request = "attach",
						},
					},
					delve = {
						initalize_timeout_sec = 20,
					},
				},
			},
		},
		keys = {
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "dap: toggle breakpoint",
			},
			{
				"<leader>dc",
				function()
					require("dap").continue()
				end,
				desc = "dap: continue",
			},
			{
				"<leader>do",
				function()
					require("dap").step_over()
				end,
				desc = "dap: step over",
			},
			{
				"<leader>di",
				function()
					require("dap").step_into()
				end,
				desc = "dap: step into",
			},
			{
				"<leader>dO",
				function()
					require("dap").step_out()
				end,
				desc = "dap: step out",
			},
			{
				"<leader>dr",
				function()
					require("dap").repl.open()
				end,
				desc = "dap: repl",
			},
			{
				"<leader>du",
				function()
					require("dapui").toggle({})
				end,
				desc = "dap: toggle dap ui",
			},
		},
		config = function()
			local dap = require("dap")
			vim.fn.sign_define("DapBreakpoint", { text = "🌈", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapBreakpointRejected", { text = "🚫", texthl = "", linehl = "", numhl = "" })
		end,
	},
}
