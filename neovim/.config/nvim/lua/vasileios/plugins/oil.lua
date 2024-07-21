local keys = require("vasileios.config.keymaps").oil

return {
   "stevearc/oil.nvim",
   dependencies = {
      "nvim-tree/nvim-web-devicons",
   },
   keys = keys or {},
   opts = {
      columns = {
         "icon",
      },
      skip_confirm_for_simple_edits = true,
      watch_for_changes = true,
      view_options = {
         show_hidden = true,
      },
   },
}

