local keys = require("vasileios.config.keymaps").toggleterm

return {
   "akinsho/toggleterm.nvim",
   version = "*",
   keys = keys or {},
   opts = {
      size = function(term)
         if term.direction == "horizontal" then
            return vim.o.lines * 0.4
         elseif term.direction == "vertical" then
            return vim.o.columns * 0.5
         end
      end,
      direction = "float",
      float_opts = {
         border = "rounded",
         title_pos = "center",
      },
   },
}

