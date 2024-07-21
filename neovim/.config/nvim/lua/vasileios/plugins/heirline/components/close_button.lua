local colors = require("vasileios.globals.colors")

return {
   update = {
      "WinNew",
      "WinClosed",
      "BufEnter",
   },

   hl = { fg = colors.purple },

   on_click = {
      name = "heirline_close_button",

      minwid = function(self)
         if self.bufnr then
            return self.bufnr
         end
         return vim.api.nvim_get_current_buf()
      end,

      callback = function(self, minwid)
         vim.schedule(function()
            vim.api.nvim_buf_delete(minwid, { force = false })
            if self.bufnr then
               vim.cmd.redrawtabline()
            end
         end)
      end,
   },

   provider = "%(%= 󰖭 %)",
}

