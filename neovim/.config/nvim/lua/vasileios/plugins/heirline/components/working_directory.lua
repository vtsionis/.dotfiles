local colors = require("vasileios.globals.colors")

local conditions = require("heirline.conditions")

return {
   hl = { fg = colors.neon_blue },

   provider = function()
      local icon = ""
      local cwd = vim.fn.getcwd(0)
      cwd = vim.fn.fnamemodify(cwd, ":~")

      if not conditions.width_percent_below(#cwd, 0.4) then
         cwd = vim.fn.pathshorten(cwd)
      end

      local trail = cwd:sub(-1) == "/" and "" or "/"
      return icon .. " " .. cwd .. trail
   end,
}

