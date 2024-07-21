local colors = require("vasileios.globals.colors")
local icons = require("vasileios.globals.icons").git

local conditions = require("heirline.conditions")

return {
   condition = conditions.is_git_repo,

   init = function(self)
      self.status = vim.b.gitsigns_status_dict
   end,

   hl = { fg = colors.bright_pink },

   provider = function(self)
      return " " .. self.status.head .. " "
   end,

   {
      provider = function(self)
         local count = self.status.added or 0
         return count > 0 and (icons.add .. self.status.added .. " ")
      end,
      hl = { fg = colors.green },
   },
   {
      provider = function(self)
         local count = self.status.changed or 0
         return count > 0 and (icons.change .. self.status.changed .. " ")
      end,
      hl = { fg = colors.orange },
   },
   {
      provider = function(self)
         local count = self.status.removed or 0
         return count > 0 and (icons.delete .. self.status.removed .. " ")
      end,
      hl = { fg = colors.red },
   },
}

