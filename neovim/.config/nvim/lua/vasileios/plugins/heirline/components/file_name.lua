local colors = require("vasileios.globals.colors")

local conditions = require("heirline.conditions")

return {
   hl = function()
      if conditions.is_active() then
         return { fg = colors.neon_blue, underline = true }
      end
      return { fg = colors.white }
   end,

   provider = function(self)
      if self.filename == "" then
         return "[No File]"
      end

      -- Display a filename that is relevant to the working directory
      local cwd = vim.fn.getcwd(0)
      local trail = cwd:sub(-1) == "/" and "" or "/"
      local filename = vim.fn.fnamemodify(self.filename, ":s?^" .. cwd .. trail .. "??")

      if not conditions.width_percent_below(#filename, 0.4) then
         filename = vim.fn.pathshorten(filename)
      end

      return filename
   end,
}

