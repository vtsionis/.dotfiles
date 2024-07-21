local colors = require("vasileios.globals.colors")

local utils = require("heirline.utils")

local C = require("vasileios.plugins.heirline.components")

-- Make sure that the tab line is visible
vim.o.showtabline = 2
vim.cmd([[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]])

return {
   hl = {
      bg = colors.black,
   },

   utils.make_buflist(
      utils.surround({ "", "" }, function(self)
         return self.is_active and colors.dark_grey or colors.black
      end, {
         C.Space(),
         C.FileIcon,
         C.Space(),
         C.BufferFileName,
         C.Space(),
         C.CloseButton,
      }),
      { provider = "", hl = { fg = colors.magenta } },
      { provider = ">", hl = { fg = colors.magenta } }
   ),

   { provider = "%=" },

   {
      hl = {
         fg = colors.yellow,
      },

      provider = " TABS: ",
   },

   utils.make_tablist(C.TabPage),
}

