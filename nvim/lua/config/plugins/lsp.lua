return {
	{
		"williamboman/mason.nvim",
		cmd = { "Mason" },
		config = {},
	},

	-- Nvim LSP
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

			local servers = {
				svelte = {},
				gopls = {},
				tsserver = {},
				rust_analyzer = {},
				sumneko_lua = {
					single_file_support = true,
					settings = {
						Lua = {
							workspace = {
								checkThirdParty = false,
							},
							completion = {
								workspaceWord = true,
								callSnippet = "Both",
							},
							misc = {
								parameters = {
									"--log-level=trace",
								},
							},
							diagnostics = {
								-- enable = false,
								groupSeverity = {
									strong = "Warning",
									strict = "Warning",
								},
								groupFileStatus = {
									["ambiguity"] = "Opened",
									["await"] = "Opened",
									["codestyle"] = "None",
									["duplicate"] = "Opened",
									["global"] = "Opened",
									["luadoc"] = "Opened",
									["redefined"] = "Opened",
									["strict"] = "Opened",
									["strong"] = "Opened",
									["type-check"] = "Opened",
									["unbalanced"] = "Opened",
									["unused"] = "Opened",
								},
								unusedLocalExclude = { "_*" },
							},
							format = {
								enable = false,
								defaultConfig = {
									indent_style = "space",
									indent_size = "2",
									continuation_indent_size = "2",
								},
							},
						},
					},
				},
			}

			local function on_attach(client, bufnr)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "LSP: Go to definition" })
				vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP: Peep definition" })
				vim.keymap.set(
					"n",
					"gt",
					vim.lsp.buf.type_definition,
					{ buffer = bufnr, desc = "LSP: Go to type definition" }
				)
				vim.keymap.set(
					"n",
					"gi",
					vim.lsp.buf.implementation,
					{ buffer = bufnr, desc = "LSP: Go to implementation" }
				)
				vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { buffer = bufnr, desc = "LSP: Rename" })
				vim.keymap.set("n", "<leader>.", vim.lsp.buf.code_action, { buffer = bufnr, desc = "LSP: Code Action" })
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

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}

			---@type _.lspconfig.options
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
				require("lspconfig")[server].setup(opts)
				-- end
			end
		end,
	},
	-- null-ls
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "BufReadPre",
		keys = {
			{ "<leader>f", vim.lsp.buf.format, { desc = "format file" } },
		},
		dependencies = {
			{
				"jay-babu/mason-null-ls.nvim",
				cmd = { "NullInstall", "NullUninstall" },
				config = {
					ensure_installed = nil,
					automatic_installation = true,
					automatic_setup = false,
				},
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
					-- formatting.prettier.with({
					--     filetypes = {
					--         "javascript",
					--         "javascriptreact",
					--         "typescript",
					--         "typescriptreact",
					--         "vue",
					--         "css",
					--         "scss",
					--         "less",
					--         "html",
					--         "json",
					--         "jsonc",
					--         "yaml",
					--         "markdown",
					--         "markdown.mdx",
					--         "graphql",
					--         "handlebars",
					--     },
					-- }),
					diagnostics.codespell,
					formatting.gofmt,
					formatting.goimports,
					formatting.goimports_reviser,
					formatting.jq,
					formatting.stylua,
					formatting.black,
					formatting.rustywind,
				},
			})
		end,
	},
}
