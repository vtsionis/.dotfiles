local M = {
    clangd = {},

    emmet_language_server = {},

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

    tsserver = {},

    vala_ls = {},
}

return M

