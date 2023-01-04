return {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "folke/neodev.nvim",
    },

    config = function()
        require("mason")

        local servers = {
            svelte = {},
            gopls = {},
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
            vim.keymap.set('n', "<leader>gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "LSP: Go to definition" })
            vim.keymap.set('n', "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP: Peep definition" })
            vim.keymap.set('n', "<leader>gtd", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "LSP: Go to type definition" })
            vim.keymap.set('n', "<leader>gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "LSP: Go to implementation" })
            vim.keymap.set('n', "<leader>r", vim.lsp.buf.rename, { buffer = bufnr, desc = "LSP: Rename" })
            vim.keymap.set('n', "<leader>.", vim.lsp.buf.code_action, { buffer = bufnr, desc = "LSP: Code Action" })
            vim.keymap.set('n', "<leader>gr", require('telescope.builtin').lsp_references, { buffer = bufnr, desc = "LSP: Go to references" })
            vim.keymap.set('n', "<leader>ps", require('telescope.builtin').lsp_dynamic_workspace_symbols, { buffer = bufnr, desc = "LSP: Go to references" })
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

}
