local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

--if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "clangd", "gopls", "templ" }

for _, lsp in ipairs(servers) do
  local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
  }
  lspconfig[lsp].setup(opts)
end

lspconfig["htmx"].setup({
  filetypes = { "html", "templ" },
})

lspconfig["tailwindcss"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
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
})

--
-- lspconfig.pyright.setup { blabla}
