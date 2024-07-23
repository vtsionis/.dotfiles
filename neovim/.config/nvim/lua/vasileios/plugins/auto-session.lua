local keys = require("vasileios.config.keymaps").auto_session

return {
   "rmagatti/auto-session",
   dependencies = {
      "nvim-telescope/telescope.nvim",
   },
   keys = keys or {},
   opts = {
      auto_session_enable_last_session = true,
      auto_session_create_enabled = false,
      auto_restore_enabled = true,
      auto_session_suppress_dirs = {
         "/",
         "~/",
         "~/Desktop/",
         "~/Documents/",
         "~/Downloads",
      },
      session_lens = {
         load_on_setup = true,
         theme_conf = { border = true },
      },
   },
}

