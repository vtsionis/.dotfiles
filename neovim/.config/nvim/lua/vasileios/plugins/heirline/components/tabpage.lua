local colors = require("vasileios.globals.colors")

return {
   hl = function(self)
      return {
         fg = self.is_active and colors.neon_blue or colors.white,
         bg = self.is_active and colors.dark_grey or colors.black,
         bold = self.is_active,
      }
   end,

   provider = function(self)
      return "%" .. self.tabnr .. "T " .. self.tabpage .. " %T"
   end,
}

