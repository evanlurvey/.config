local M = {
    "williamboman/mason.nvim",
    cmd = { "Mason" },
    dependencies = {
    },
}

M.tools = {
    "prettierd",
    "stylua",
    "selene",
    "luacheck",
    "eslint_d",
    "shellcheck",
    "shfmt",
    "black",
    "isort",
    "flake8",
}

function M.check()
    local mr = require("mason-registry")
    for _, tool in ipairs(M.tools) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
            p:install()
        end
    end
end

function M.config()
    require("mason").setup()

    require("mason-lspconfig").setup({
        automatic_installation = true, 
    })
end 

return {
    M,
    -- required for stuff, idk dog
    "williamboman/mason-lspconfig.nvim",
}
