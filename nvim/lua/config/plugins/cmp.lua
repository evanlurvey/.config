local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {

    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "rafamadriz/friendly-snippets",
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
            end,
        },
        config = function ()
            require("luasnip").config.setup({
                history = true,
                enable_autosnippets = true,
                updateevents = "TextChanged,TextChangedI",
            })
        end
    },

    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-emoji",
            "saadparwaiz1/cmp_luasnip",
            "onsails/lspkind.nvim",
        },

        config = function()
            local cmp = require("cmp")
            local lspkind = require('lspkind')
            local luasnip = require('luasnip')

            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-n>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ['<C-p>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),

                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                -- idk if I see a difference with the windows...
                window = {
                    compleation = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "path" },
                    { name = "luasnip" },
                    { name = "emoji" },
                }),
                formatting = {
                    format = lspkind.cmp_format {
                        with_text = true,
                        menu = {
                            nvim_lsp = "[LSP]",
                            buffer = "[Buf]",
                            path = "[path]",
                            luasnip = "[snip]",
                            emoji = "[emoji]",
                        },
                    },
                },
                experimental = {
                    ghost_text = true,
                },
            })

            -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
            -- This should fix tab not workin in cmd with lsp on
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline({
                    ["<Tab>"] = {
                        c = function (fallback)
                            local cmp = require('cmp')
                            if cmp.visible() then
                                cmp.select_next_item()
                            else
                                fallback()
                            end
                        end
                    },
                    ["<S-Tab>"] = {
                        c = function (fallback)
                            local cmp = require('cmp')
                            if cmp.visible() then
                                cmp.select_prev_item()
                            else
                                fallback()
                            end
                        end
                    },
                }),
                sources = {
                    { name = 'buffer' }
                }
            })

        end,
    },
}


