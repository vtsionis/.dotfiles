local servers_ok, servers = pcall(require, "plugins.lsp.servers")
if not servers_ok then return end

local ensure_installed = {}
for server_name in pairs(servers) do
    table.insert(ensure_installed, server_name)
end

return {
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        cmd = {
            "Mason",
            "MasonInstall",
            "MasonInstallAll",
            "MasonUninstall",
            "MasonUninstallAll",
            "MasonLog",
        },
        config = function()
            -- Create the custom MasonInstallAll command
            vim.api.nvim_create_user_command("MasonInstallAll", function()
                vim.cmd("MasonInstall " .. table.concat(ensure_installed, " "))
            end, {})

            require("mason").setup({
                PATH = "prepend",

                -- Set this to vim.log.levels.DEBUG when debugging issues with
                -- package installations.
                log_level = vim.log.levels.INFO,

                max_concurrent_installers = 10,

                ui = {
                    border = "single",
                    icons = {
                        package_installed = "🗸",
                        package_pending = "󰇚",
                        package_uninstalled = "",
                    },
                },
            })
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = ensure_installed,
                automatic_installation = true,
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        event = {
            "BufEnter",
            "BufReadPre",
            "BufNewFile",
        },
        config = function()
            local lspc_ok, lspc = pcall(require, "lspconfig")
            if not lspc_ok then return end

            local handlers_ok, handlers = pcall(require, "plugins.lsp.handlers")
            if handlers_ok then
                handlers.setup()
            end

            for _, server_name in ipairs(ensure_installed) do
                lspc[server_name].setup(servers[server_name])
            end
        end,
    },
}

