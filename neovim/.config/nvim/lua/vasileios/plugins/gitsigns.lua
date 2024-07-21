local keys = require("vasileios.config.keymaps").gitsigns

return {
   "lewis6991/gitsigns.nvim",
   event = {
      "BufReadPost",
      "BufNewFile",
      "BufWritePre",
   },
   keys = keys or {},
   opts = {
      preview_config = {
         border = "rounded",
      },
   },
}

