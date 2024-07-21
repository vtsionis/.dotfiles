return {
   "folke/which-key.nvim",
   event = "VeryLazy",
   dependencies = {
      "nvim-tree/nvim-web-devicons",
   },
   opts = {
      preset = "helix",
      delay = 800,
      filter = function(mapping)
         return mapping.desc and mapping.desc ~= ""
      end,
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

