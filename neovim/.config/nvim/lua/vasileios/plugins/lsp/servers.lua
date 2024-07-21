local M = {
   -- LSPs
   clangd = {},

   lua_ls = {
      settings = {
         Lua = {
            completion = {
               callSnippet = "Both",
               keywordSnippet = "Both",
               postfix = "@", -- Default value
            },
            diagnostics = {
               globals = {
                  "vim",
               },
            },
            hint = {
               arrayIndex = "Disable",
               enable = true,
            },
            telemetry = {
               enable = false,
            },
            workspace = {
               checkThirdParty = "Disable",
            },
         },
      },
   },

   pyright = {
      handlers = {
         -- Example of overwriting a handler method for a specific server
         ["textDocument/rename"] = function(err, result, ctx, config)
            vim.lsp.handlers["textDocument/rename"](err, result, ctx, config)
         end,
      },
   },

   tsserver = {},

   -- Linters
   eslint = {},
}

return M

