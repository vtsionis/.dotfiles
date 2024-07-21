local lazyroot = vim.fn.stdpath("data") .. "/lazy"
local lazypath = lazyroot .. "/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
   vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "--branch=stable",
      "https://github.com/folke/lazy.nvim.git",
      lazypath,
   })
end

vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup({
   spec = {
      {
         import = "vasileios.plugins",
      },
      {
         import = "vasileios.plugins.treesitter.modules",
      },
      {
         import = "vasileios.plugins.mini",
      },
   },
   root = lazyroot,
   defaults = {
      -- Lazy or eager load on a plugin base
      lazy = false,
   },
   lockfile = lazyroot .. "/lazy-lock.json",
   rocks = {
      enable = true,
      root = lazyroot .. "/rocks",
      hererocks = false,
   },
   dev = {
      path = "~/Software-Development/Neovim/plugins",
      fallback = false,
   },
   install = {
      missing = true,
      colorscheme = { "catppuccin" },
   },
   ui = {
      size = {
         width = 0.85,
         height = 0.85,
      },
      wrap = true,
      border = "rounded",
      backdrop = 100,
      title = " Lazy Menu ",
      title_pos = "center",
      pills = true,
      icons = {
         cmd = " ",
         config = "",
         event = " ",
         favorite = " ",
         ft = " ",
         init = " ",
         import = " ",
         keys = " ",
         lazy = "󰒲 ",
         loaded = "●",
         not_loaded = "○",
         plugin = " ",
         runtime = " ",
         require = "󰢱 ",
         source = " ",
         start = " ",
         task = "✔ ",
         list = {
            "●",
            "➜",
            "★",
            "‒",
         },
      },
   },
   checker = {
      enabled = true,
      notify = false,
   },
   change_detection = {
      notify = false,
   },
})

