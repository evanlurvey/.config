---@type MappingsTable
local M = {}

M.disabled = {
  n = {
    ["<tab>"] = "",
    ["<S-tab>"] = "",
  },
  t = {
    ["<C-d"] = "",
  },
}

M.telescope = {
  n = {
    ["<leader>fw"] = { "<cmd> Telescope live_grep hidden=true<CR>", "Live grep" },
    ["<leader>ff"] = { "<cmd> Telescope find_files hidden=true<CR>", "Find files" },
  },
}

M.nvterm = {
  t = {
    ["<C-w>"] = {
      "<C-\\><C-n><C-w>",
      "ctl w is like never used just forward it",
    },
  },
}

M.nvimtree = {
  n = {
    ["<leader>tt"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
    ["<leader>t."] = { "<cmd> NvimTreeFocus <CR>", "Focus nvimtree to current file" },
  },
}

M.tabufline = {
  n = {
    -- cycle through buffers
    ["L"] = {
      function()
        require("nvchad.tabufline").tabuflineNext()
      end,
      "Goto next buffer",
    },
    ["H"] = {
      function()
        require("nvchad.tabufline").tabuflinePrev()
      end,
      "Goto prev buffer",
    },
    ["<C-x>"] = {
      function()
        require("nvchad.tabufline").close_buffer()
      end,
      "Close buffer",
    },
  },
}

M.lspconfig = {
  n = {
    ["<leader>dp"] = {
      function()
        vim.diagnostic.goto_prev { float = { border = "rounded" } }
      end,
      "Goto prev",
    },

    ["<leader>dn"] = {
      function()
        vim.diagnostic.goto_next { float = { border = "rounded" } }
      end,
      "Goto next",
    },
    ["<leader>."] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "LSP code action",
    },
    ["<leader>dl"] = {
      "<cmd>Telescope diagnostics<cr>",
      "List diagnostics (errors, warnings)",
    },
  },
}
-- vim.keymap.set("n", "<leader>y", '"+y')
-- vim.keymap.set("v", "<leader>y", '"+y')
-- vim.keymap.set("n", "<leader>Y", '"+Y')

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },

    --  format with conform
    ["<leader>fm"] = {
      function()
        require("conform").format()
      end,
      "formatting",
    },

    ["<leader>y"] = { '"+y', "Yank to system clipboard" },
    ["<leader>Y"] = { '"+Y', "Yank to system clipboard" },
  },
  v = {
    [">"] = { ">gv", "indent" },
    ["<leader>y"] = { '"+y', "Yank to system clipboard" },
  },
}

-- more keybinds!

return M
