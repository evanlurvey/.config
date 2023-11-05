local function on_attach(client, bufnr)
	-- if client.server_capabilities.documentHighlightProvider then
	--     vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
	--     vim.api.nvim_clear_autocmds({ buffer = bufnr, group = "lsp_document_highlight" })
	--     vim.api.nvim_create_autocmd("CursorHold", {
	--         callback = vim.lsp.buf.document_highlight,
	--         buffer = bufnr,
	--         group = "lsp_document_highlight",
	--         desc = "Document Highlight",
	--     })
	--     vim.api.nvim_create_autocmd("CursorMoved", {
	--         callback = vim.lsp.buf.clear_references,
	--         buffer = bufnr,
	--         group = "lsp_document_highlight",
	--         desc = "Clear All the References",
	--     })
	-- end
	-- vim.keymap.set("n", "<leader>f", formatCmd, { buffer = bufnr, desc = "LSP: Format file" })
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "LSP: Go to definition" })
	vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP: Peep definition" })
	vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "LSP: Go to type definition" })
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "LSP: Go to implementation" })
	vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { buffer = bufnr, desc = "LSP: Rename" })
	vim.keymap.set("n", "<leader>.", vim.lsp.buf.code_action, { buffer = bufnr, desc = "LSP: Code Action" })
	vim.keymap.set("i", "<C-.>", vim.lsp.buf.code_action, { buffer = bufnr, desc = "LSP: Code Action" })
	vim.keymap.set(
		"n",
		"gr",
		require("telescope.builtin").lsp_references,
		{ buffer = bufnr, desc = "LSP: Go to references" }
	)
	vim.keymap.set(
		"n",
		"<leader>S",
		require("telescope.builtin").lsp_dynamic_workspace_symbols,
		{ buffer = bufnr, desc = "LSP: search workspace symbols" }
	)
	vim.keymap.set(
		"n",
		"<leader>s",
		require("telescope.builtin").lsp_document_symbols,
		{ buffer = bufnr, desc = "LSP: search document symbols" }
	)
end

return {
	{
		"github/copilot.vim",
		event = "VeryLazy",
	},
	{
		"williamboman/mason.nvim",
		cmd = { "Mason" },
		config = {},
	},
	-- -- Nvim LSP
	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"folke/neodev.nvim",
			{
				"williamboman/mason-lspconfig.nvim",
				config = {
					automatic_installation = true,
				},
			},
		},
		config = function()
			require("mason")
			local lspconfig = require("lspconfig")

			local servers = {
				html = {},
				svelte = {},
				gopls = {},
				templ = {},
				tsserver = {},
				graphql = {},
				tailwindcss = {
					filetypes = {
						"html",
						"svelte",
						"css",
						"templ",
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
					},
					init_options = {
						userLanguages = {
							templ = "html",
						},
					},
				},
				cssls = {},
				yamlls = {},
				lua_ls = {},
				-- yamlls = {},
				kotlin_language_server = {},
				pylsp = {},
				sqlls = {},

				-- rust_analyzer = {
				-- 	imports = {
				-- 		granularity = {
				-- 			group = "module",
				-- 		},
				-- 		prefix = "self",
				-- 	},
				-- 	cargo = {
				-- 		buildScripts = {
				-- 			enable = true,
				-- 		},
				-- 	},
				-- 	procMacro = {
				-- 		enable = true,
				-- 	},
				-- },
			}

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
			-- capabilities.textDocument.completion.completionItem.snippetSupport = true
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}

			---@type lspconfig.options
			local options = {
				on_attach = on_attach,
				capabilities = capabilities,
				flags = {
					debounce_text_changes = 150,
				},
			}

			for server, opts in pairs(servers) do
				opts = vim.tbl_deep_extend("force", {}, options, opts or {})
				-- if server == "tsserver" then
				--     require("typescript").setup({ server = opts })
				-- else
				lspconfig[server].setup(opts)
				-- end
			end
		end,
	},
	-- -- null-ls
	{
		"jay-babu/mason-null-ls.nvim",
		event = "BufReadPre",
		cmd = { "NullInstall", "NullUninstall" },
		config = {
			ensure_installed = nil,
			automatic_installation = true,
			automatic_setup = false,
		},
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "BufReadPre",
		keys = {
			{
				"<leader>f",
				function()
					vim.lsp.buf.format({ timeout_ms = 5000 })
				end,
				{ desc = "format file" },
			},
		},
		config = function()
			local null_ls = require("null-ls")
			local formatting = null_ls.builtins.formatting
			local diagnostics = null_ls.builtins.diagnostics
			local code_actions = null_ls.builtins.code_actions
			null_ls.setup({
				debug = true,
				sources = {
					formatting.eslint_d.with({
						filetypes = {
							"javascript",
							"javascriptreact",
							"typescript",
							"typescriptreact",
							"vue",
							"svelte",
						},
					}),
					diagnostics.eslint_d.with({
						filetypes = {
							"javascript",
							"javascriptreact",
							"typescript",
							"typescriptreact",
							"vue",
							"svelte",
						},
					}),
					code_actions.eslint_d.with({
						filetypes = {
							"javascript",
							"javascriptreact",
							"typescript",
							"typescriptreact",
							"vue",
							"svelte",
						},
					}),
					formatting.prettier.with({
						filetypes = {
							"javascript",
							"javascriptreact",
							"typescript",
							"typescriptreact",
							"vue",
							"svelte",
							"css",
							"scss",
							"less",
							"html",
							"json",
							"jsonc",
							"yaml",
							"markdown",
							"markdown.mdx",
							-- "graphql",
							"handlebars",
						},
					}),
					diagnostics.codespell,
					-- FIX: I don't think this is working the way that I want it to.
					-- I want to be able to code action spelling mistakes
					formatting.goimports,
					formatting.jq,
					formatting.stylua,
					formatting.black,
					formatting.rustywind.with({
						filetypes = {
							"html",
							"svelte",
							"css",
							"templ",
							"javascript",
							"javascriptreact",
							"typescript",
							"typescriptreact",
						},
					}),
					-- Yaml / CFT
					formatting.yamlfmt,
					diagnostics.cfn_lint,
					diagnostics.yamllint,
				},
			})
		end,
	},
}
