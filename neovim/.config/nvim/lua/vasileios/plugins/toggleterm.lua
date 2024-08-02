local keys = require("vasileios.config.keymaps").toggleterm

return {
   "akinsho/toggleterm.nvim",
   version = "*",
   keys = keys or {},
   opts = {
      direction = "float",
      float_opts = {
         border = "rounded",
         title_pos = "center",
      },
   },
}

