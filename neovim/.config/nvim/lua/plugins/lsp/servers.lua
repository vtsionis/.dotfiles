local M = {
    -- LSPs
    clangd = {},

    lua_ls = {
        settings = {
            Lua = {
                diagnostics = {
                    globals = {
                        "vim",
                    },
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false,
                },
                telemetry = {
                    enable = false,
                },
            },
        },
    },

    pyright = {},

    tsserver = {},

    -- Linters
    eslint = {},
}

return M

