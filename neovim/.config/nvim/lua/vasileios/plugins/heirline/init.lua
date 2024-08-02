local colors = require("vasileios.globals.colors")

local globals = require("vasileios.plugins.heirline.globals")

return {
   "rebelot/heirline.nvim",
   dependencies = {
      "nvim-tree/nvim-web-devicons",
      "lewis6991/gitsigns.nvim",
   },
   event = "UiEnter",
   config = function()
      local StatusLine = require("vasileios.plugins.heirline.statusline")
      local TabLine = require("vasileios.plugins.heirline.tabline")
      local Winbar = require("vasileios.plugins.heirline.winbar")

      require("heirline").setup({
         statusline = {
            condition = function()
               for _, filetype in pairs(globals.disabled_filetypes) do
                  if vim.bo.filetype == filetype then
                     return false
                  end
               end
               return true
            end,

            hl = { bg = colors.black },

            StatusLine,
         },
         winbar = Winbar,
         tabline = TabLine,
         opts = {
            disable_winbar_cb = function()
               for _, filetype in pairs(globals.winbar_disabled_filetypes) do
                  if vim.bo.filetype == filetype then
                     return true
                  end
               end
            end,
         },
      })
   end,
}

