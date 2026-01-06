require("config.lazy")

-- Set theme
vim.cmd([[colorscheme tokyonight-night]])

vim.g.mapleader = " "

-- musts
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 4

-- clipboard
--vim.opt.clipboard = ""

-- indent
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

-- extra file support
vim.filetype.add({
	extension = {
		templ = "templ",
	},
})

-- NOTE: DON'T FORGET TO ENABLE THE LSP AFTER YOU ADD IT'S FILE
-- lsp
vim.lsp.enable({
	"lua_ls",
	"gopls",
	"pyright",
	"ruff",
})

local autocmd = vim.api.nvim_create_autocmd
local harpoon = require("harpoon")
harpoon:setup()

-- KEYMAPPING

-- date
vim.keymap.set("n", "\\d", ":read !date<CR>gcc", { remap = true, desc = "adds a commented date" })
-- make the highlight go away
vim.keymap.set("n", "<ESC>", "<CMD>nohlsearch<CR>", { desc = "Clear search highlight" })
-- buffers
vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR>", { desc = "Save buffer" })
vim.keymap.set("n", "L", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "H", "<cmd>bprev<CR>", { desc = "Previous buffer" })

-- TODO: this close is not working how I want
-- I want to reopen something I closed with ctrl-o
-- I want it to close the buffer when its the last reference
vim.keymap.set("n", "<C-x>", function()
	if vim.api.nvim_win_get_config(0).relative ~= "" then
		vim.api.nvim_win_close(0, false)
		return
	end

	if #vim.api.nvim_list_wins() > 1 then
		vim.cmd("close")
		return
	end

	local buf = vim.api.nvim_get_current_buf()

	if vim.bo[buf].modified then
		local choice = vim.fn.confirm("Unsaved changes", "&Save\n&Discard\n&Cancel", 3)
		if choice == 1 then
			vim.cmd("write")
		elseif choice == 2 then
			vim.bo[buf].modified = false
		else
			return
		end
	end

	local listed = vim.fn.getbufinfo({ buflisted = 1 })
	if #listed > 1 then
		vim.cmd("bprevious")
	else
		vim.cmd("enew")
	end
	vim.bo[buf].buflisted = false
end, { desc = "Smart close" })
-- file browsing
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
-- clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank line to system clipboard" })
-- code diagnostics
vim.keymap.set("n", "<leader>dn", function()
	vim.diagnostic.jump({ count = 1, float = { border = "rounded" } })
end, { desc = "Go to next diagnostic" })
vim.keymap.set("n", "<leader>dp", function()
	vim.diagnostic.jump({ count = -1, float = { border = "rounded" } })
end, { desc = "Go to prev diagnostic" })
vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", { desc = "Diagnostic List" })
-- gotos / code actions
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition under cursor" })
vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<cr>", { desc = "Go to Implementation(s) under cursor" })
vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", { desc = "List References under cursor" })
vim.keymap.set("n", "<leader>.", vim.lsp.buf.code_action, { desc = "LSP Code Action" })
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "LSP Rename" })
-- telescope
vim.keymap.set("n", "<leader>fw", "<cmd>Telescope live_grep hidden=true<cr>", { desc = "Find Words (live grep)" })
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files hidden=true<cr>", { desc = "Find Files" })
vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<cr>", { desc = "Find Files" })

-- TODO: I want to make sure undo works, maybe even that branching style one idk. Double check it tho.
--
-- also should check and see if there is any other standard things I should throw into the config.
