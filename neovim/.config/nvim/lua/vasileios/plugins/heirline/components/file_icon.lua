return {
   init = function(self)
      local filename = self.filename
      if not filename then
         -- When use in the tabline, the explicit buffer number needs to be
         -- provided
         filename = vim.api.nvim_buf_get_name(self.bufnr or 0)
      end
      local extension = vim.fn.fnamemodify(filename, ":e")
      self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
   end,

   hl = function(self)
      return { fg = self.icon_color }
   end,

   provider = function(self)
      return self.icon
   end,
}

