return {
   "folke/which-key.nvim",
   event = "VeryLazy",
   dependencies = {
      "nvim-tree/nvim-web-devicons",
   },
   opts = {
      preset = "modern",
      triggers = {
         { "<auto>", mode = { "n", "i" } },
      },
      plugins = {
         spelling = {
            enabled = false,
         },
         presets = {
            operators = false,
            motions = false,
            text_objects = false,
            windows = false,
            nav = false,
            z = false,
            g = false,
         },
      },
      win = {
         border = "rounded",
         padding = { 1, 1, 1, 1 },
         title = " Keymaps ",
         title_pos = "center",
      },
   },
}

