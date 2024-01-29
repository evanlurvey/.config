vim.opt.relativenumber = true
vim.opt.clipboard = ""
vim.opt.scrolloff = 4

vim.filetype.add {
  extension = {
    templ = "templ",
  },
}

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
--
local autocmd = vim.api.nvim_create_autocmd
autocmd("BufWritePre", {
  pattern = { "*.templ", "*.go" },
  callback = function()
    -- Format the current buffer using Neovim's built-in LSP (Language Server Protocol).
    vim.lsp.buf.format()
  end,
})
