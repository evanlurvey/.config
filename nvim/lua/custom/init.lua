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
    require("conform").format()
  end,
})
autocmd("BufWritePre", {
  pattern = { "*.templ"  },
  callback = function()
    vim.cmd("!templ generate")
  end,
})
