local colors = require("vasileios.globals.colors")
local icons = require("vasileios.globals.icons").diagnostics

local conditions = require("heirline.conditions")

return {
   condition = conditions.has_diagnostics,

   update = {
      "DiagnosticChanged",
      "BufEnter",
   },

   init = function(self)
      self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
      self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
      self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
      self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
   end,

   {
      hl = { fg = colors.red },
      provider = function(self)
         return self.errors > 0 and (icons.error .. " " .. self.errors .. " ")
      end,
   },
   {
      hl = { fg = colors.orange },
      provider = function(self)
         return self.warnings > 0 and (icons.warn .. " " .. self.warnings .. " ")
      end,
   },
   {
      hl = { fg = colors.neon_blue },
      provider = function(self)
         return self.hints > 0 and (icons.hint .. " " .. self.hints .. " ")
      end,
   },
   {
      hl = { fg = colors.bright_cyan },
      provider = function(self)
         return self.info > 0 and (icons.info .. " " .. self.info .. " ")
      end,
   },
}

