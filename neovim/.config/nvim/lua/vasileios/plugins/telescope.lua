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
      local action_layout = require("telescope.actions.layout")
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
         defaults = {
            sorting_strategy = "ascending",
            layout_config = {
               height = 0.9,
               preview_cutoff = 120,
               width = 0.9,

               horizontal = {
                  propmt_position = "bottom",
               },
            },
            wrap_results = true,
            prompt_prefix = " ",
            dynamic_preview_title = true,
            file_ignore_patterns = {
               ".git",
               "node_modules",
            },

            mappings = {
               n = {
                  ["<M-p>"] = action_layout.toggle_preview,
               },
               i = {
                  ["<M-p>"] = action_layout.toggle_preview,
               },
            },
         },

         pickers = {
            find_files = {
               find_command = {
                  "rg",
                  "--hidden",
                  "--files",
                  "--sort", "path"
               },
            },
         },

         extensions = extensions,
      })

      for extension in pairs(extensions) do
         telescope.load_extension(extension)
      end
   end,
}

