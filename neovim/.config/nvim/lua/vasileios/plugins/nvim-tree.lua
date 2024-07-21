local icons = require("vasileios.globals.icons").diagnostics
local keys = require("vasileios.config.keymaps").nvim_tree

local WIDTH_RATIO = 0.85
local HEIGHT_RATIO = 0.85

return {
   "nvim-tree/nvim-tree.lua",
   version = "*",
   lazy = false,
   dependencies = {
      "nvim-tree/nvim-web-devicons",
   },
   keys = keys or {},
   config = function()
      require("nvim-tree").setup({
         view = {
            float = {
               enable = true,
               open_win_config = function()
                  local screen_w = vim.opt.columns:get()
                  local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
                  local window_w = screen_w * WIDTH_RATIO
                  local window_h = screen_h * HEIGHT_RATIO
                  local window_w_int = math.floor(window_w)
                  local window_h_int = math.floor(window_h)
                  local center_x = (screen_w - window_w) / 2
                  local center_y = ((vim.opt.lines:get() - window_h) / 2)
                  - vim.opt.cmdheight:get()

                  return {
                     border = "rounded",
                     relative = "editor",
                     row = center_y,
                     col = center_x,
                     width = window_w_int,
                     height = window_h_int,
                     title = " File Explorer ",
                     title_pos = "center",
                  }
               end,
            },
         },
         renderer = {
            full_name = true,
            special_files = {},
            highlight_git = "name",
            highlight_modified = "name",
            indent_markers = {
               enable = true,
               icons = {
                  corner = "└",
                  edge = "┆ ",
                  item = "┆ ",
                  bottom = "─",
                  none = " ",
               },
            },
            icons = {
               git_placement = "after",
               glyphs = {
                  folder = {
                     arrow_closed = "󰥭",
                     arrow_open = "⌄",
                  },
                  git = {
                     unstaged = "M",
                     staged = "S",
                     renamed = "R",
                     untracked = "N",
                     deleted = "D",
                  },
               },
            },
         },
         update_focused_file = {
            enable = false,
         },
         diagnostics = {
            enable = true,
            show_on_dirs = true,
            icons = {
               error = icons.error,
               warning = icons.warn,
               info = icons.info,
               hint = icons.hint,
            },
         },
         modified = {
            enable = true,
         },
         filters = {
            git_ignored = false,
            dotfiles = true,
            git_clean = false,
         },
         filesystem_watchers = {
            ignore_dirs = {
               "node_modules",
            },
         },
         ui = {
            confirm = {
               remove = false,
               trash = false,
               default_yes = true,
            },
         },
      })
   end,
}

