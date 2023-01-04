--this is for closing the buffer
vim.keymap.set("n", "<leader>c", vim.cmd.bd)

vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
vim.keymap.set("n", "<leader>w", vim.cmd.w)


-- page down and up then center screen with zz
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- searching with center screen
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

-- for not clearing paste buffer 
vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- copy paste with system
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- for moving thing up and down a few lines instead of yank and delete 
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

vim.keymap.set("n", "<leader>nvw", function() vim.cmd('vertical split') end, { desc = "New Vertical Window" })
vim.keymap.set("n", "<leader>nhw", vim.cmd.split, { desc = "New Horizontal Window" })

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])


-- Format whole file
vim.keymap.set("n", "==", "mTgg^=G`T")


-- Diagnostics 
vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev)
vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>")


