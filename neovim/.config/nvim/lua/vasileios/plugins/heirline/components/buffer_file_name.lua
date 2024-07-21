local colors = require("vasileios.globals.colors")

return {
   init = function(self)
      self.filename = vim.api.nvim_buf_get_name(self.bufnr)
   end,

   hl = function(self)
      return {
         fg = self.is_active and colors.neon_blue or colors.white,
      }
   end,

   provider = function(self)
      if self.filename == "" then
         return "[No File]"
      end

      -- Display a filename that is relevant to the working directory
      local cwd = vim.fn.getcwd(0)
      local trail = cwd:sub(-1) == "/" and "" or "/"
      local filename = vim.fn.fnamemodify(self.filename, ":s?^" .. cwd .. trail .. "??")

      return filename
   end,
}

