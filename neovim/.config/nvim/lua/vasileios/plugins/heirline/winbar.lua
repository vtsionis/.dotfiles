local colors = require("vasileios.globals.colors")

local C = require("vasileios.plugins.heirline.components")

return {
   init = function(self)
      self.filename = vim.api.nvim_buf_get_name(0)
   end,

   hl = { bg = colors.dark_grey },

   C.Space(),
   C.FileIcon,
   C.Space(),
   C.FileName,
   C.Space(),
   C.FileFlags,
   C.Space(),

   { provider = "%<" }, -- cut here if not enough space
   C.Diagnostics,

   { provider = "%=" },

   C.CloseButton,
}

