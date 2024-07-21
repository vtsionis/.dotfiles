local icons = require("vasileios.globals.icons").diagnostics

local M = {}

-- Define diagnostic signs
local diagnostic_signs = {
   { name = "DiagnosticSignError", text = icons.error },
   { name = "DiagnosticSignWarn", text = icons.warn },
   { name = "DiagnosticSignInfo", text = icons.info },
   { name = "DiagnosticSignHint", text = icons.hint },
   { name = "DiagnosticSignOk", text = icons.ok },
}
for _, sign in ipairs(diagnostic_signs) do
   vim.fn.sign_define(sign.name, {
      text = sign.text,
      texthl = sign.name,
      numhl = sign.name,
   })
end

local diagnostics = {
   underline = true,
   virtual_text = {
      source = false,
      spacing = 3,
      prefix = function(diagnostic)
         return ""
      end,
      suffix = function(diagnostic)
         if (diagnostic.code) then
            return string.format(" [%s]", diagnostic.code)
         end
      end,
      hl_mode = "blend",
      virt_text_pos = "eol",
   },
   float = {
      border = "rounded",
   },
   update_in_insert = true,
   severity_sort = true,
}

M.setup = function()
   vim.diagnostic.config(diagnostics)

   -- Setup of global handler methods
   vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover,
      diagnostics.float
   )

   vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
      vim.lsp.handlers.signature_help,
      diagnostics.float
   )
end

return M

