local keys = require("vasileios.config.keymaps").telescope

return {
   "nvim-telescope/telescope.nvim",
   branch = "0.1.x",
   event = "VimEnter",
   dependencies = {
      -- Required
      "nvim-lua/plenary.nvim",

      -- Suggested
      "BurntSushi/ripgrep",
      "nvim-telescope/telescope-ui-select.nvim",

      -- Native telescope sorter
      {
         "nvim-telescope/telescope-fzf-native.nvim",
         build = "make",
      },

      -- Optional
      "nvim-tree/nvim-web-devicons",
   },
   cmd = "Telescope",
   keys = keys or {},
   config = function()
      local telescope = require("telescope")
      local themes = require("telescope.themes")

      local extensions = {
         fzf = {
            case_mode = "respect_case",
         },

         ["ui-select"] = {
            themes.get_dropdown(),
         },
      }

      telescope.setup({
         extensions = extensions,
      })

      for extension in pairs(extensions) do
         telescope.load_extension(extension)
      end
   end,
}

