local servers = require("vasileios.plugins.lsp.servers")
local handlers = require("vasileios.plugins.lsp.handlers")

local capabilities = vim.lsp.protocol.make_client_capabilities()

local ensure_installed = {}
for server_name in pairs(servers) do
   table.insert(ensure_installed, server_name)
end

local mason_to_lspconfig_server_name = function(mapping, name)
   for lspconfig_name, mason_name in pairs(mapping) do
      if mason_name == name then
         return lspconfig_name
      end
   end
end

local events_list = {
   "BufEnter",
   "BufReadPre",
   "BufNewFile",
}

return {
   {
      "williamboman/mason.nvim",
      build = ":MasonUpdate",
      cmd = "Mason",
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
            },
         })
      end,
   },
   {
      "williamboman/mason-lspconfig.nvim",
      event = events_list,
      opts = {
         ensure_installed = ensure_installed,
         automatic_installation = true,
      },
   },
   {
      "neovim/nvim-lspconfig",
      event = events_list,
      config = function()
         require("lspconfig.ui.windows").default_options.border = "rounded"

         local lspconfig = require("lspconfig")

         local cmp_capabilities = {}
         local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
         if ok then
            cmp_capabilities = cmp_nvim_lsp.default_capabilities() or {}
         end

         -- First, setup the global handlers
         handlers.setup()

         for _, server_name in ipairs(ensure_installed) do
            local server_config = servers[server_name] or {}

            server_config.capabilities = vim.tbl_deep_extend("force",
               {},
               capabilities,
               cmp_capabilities,
               server_config.capabilities or {}
            )

            lspconfig[server_name].setup(server_config)
         end

         -- Manually call the setup method passing any existing configuration,
         -- every time a new language server is installed; That way the LSP
         -- can be attached to any open buffers, if applicable, without the
         -- need to restart Neovim
         local registry = require("mason-registry")
         local mapping = require("mason-lspconfig.mappings.server")

         -- https://github.com/williamboman/mason.nvim/blob/main/doc/reference.md#registry-events
         registry:on("package:install:success", vim.schedule_wrap(function(pkg)
            -- pkg.name is the server name according to Mason
            -- i.e. "lua-language-server" so we need to map it to its
            -- corresponding lspconfig server name i.e. "lua_ls"
            local server_name = mason_to_lspconfig_server_name(mapping.lspconfig_to_package, pkg.name)
            if server_name then
               lspconfig[server_name].setup(servers[server_name] or {})
            end
         end))
      end,
   },
}

