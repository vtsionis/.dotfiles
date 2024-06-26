local servers = require("plugins.lsp.servers")
local handlers = require("plugins.lsp.handlers")

local ensure_installed = {}
for server_name in pairs(servers) do
    table.insert(ensure_installed, server_name)
end

local function mason_to_lspconfig_server_name(mapping, name)
    for lspconfig_name, mason_name in pairs(mapping) do
        if mason_name == name then
            return lspconfig_name
        end
    end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}

local events_list = {
    "BufEnter",
    "BufReadPre",
    "BufNewFile",
}

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
               install_root_dir = vim.fn.stdpath("data") .. "/mason",
                PATH = "prepend",
                log_level = vim.log.levels.INFO,
                max_concurrent_installers = 10,

                ui = {
                    border = "rounded",
                    width = 0.85,
                    height = 0.85,

                    icons = {
                        package_installed = "🗸",
                        package_pending = "󰇚",
                        package_uninstalled = "✗",
                    },

                    keymaps = {
                        -- Expand a package
                        toggle_package_expand = "<CR>",
                        -- Install the package under the cursor
                        install_package = "i",
                        -- Reinstall/update the package under the cursor
                        update_package = "u",
                        -- Check for new version for the package under cursor
                        check_package_version = "c",
                        -- Update all installed packages
                        update_all_packages = "U",
                        -- Check outdated installed packages
                        check_outdated_packages = "C",
                        -- Uninstall a package
                        uninstall_package = "X",
                        -- Cancel a package installation
                        cancel_installation = "<C-c>",
                        -- Apply language filter
                        apply_language_filter = "<C-f>",
                        -- Toggle viewing package installation log
                        toggle_package_install_log = "<CR>",
                        -- Toggle the help menu
                        toggle_help = "g?",
                    },
                },
            })
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        event = events_list,
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = ensure_installed,
                automatic_installation = true,
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        event = events_list,
        config = function()
            local lspconfig = require("lspconfig")

            handlers.setup()

            for _, server_name in ipairs(ensure_installed) do
                local settings = servers[server_name]
                settings.capabilities = capabilities

                lspconfig[server_name].setup(settings)
            end

            local registry = require("mason-registry")
            local mapping = require("mason-lspconfig.mappings.server")

            -- Manually call the setup method passing any existing configuration,
            -- every time a new language server is installed; That way the LSP
            -- can be attached to any open buffers, if applicable, without the
            -- need to restart Neovim
            registry:on(
              -- https://github.com/williamboman/mason.nvim/blob/main/doc/reference.md#registry-events
              "package:install:success",
              vim.schedule_wrap(function(pkg)
                  -- pkg.name is the server name according to Mason
                  -- i.e. "lua-language-server" so we need to map it to its
                  -- corresponding lspconfig server name i.e. "lua_ls"
                  local server_name = mason_to_lspconfig_server_name(mapping.lspconfig_to_package, pkg.name)
                  if server_name then
                      lspconfig[server_name].setup(servers[server_name] or {})
                  end
              end)
            )
        end,
    },
}

