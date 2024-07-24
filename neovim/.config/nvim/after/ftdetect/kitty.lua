local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local kitty_group = augroup("KittyGroup", { clear = true })

local events = {
   "BufNewFile",
   "BufRead",
}

autocmd(events, {
   desc = "Detect Kitty configuration files",
   group = kitty_group,
   pattern = {
      "kitty.conf",
      "*/kitty/*.conf",
   },
   callback = function()
      vim.cmd([[setfiletype kitty]])
   end,
})

autocmd(events, {
   desc = "Detect Kitty session files",
   group = kitty_group,
   pattern = {
      "*/kitty/*.session",
   },
   callback = function()
      vim.cmd([[setfiletype kitty-session]])
   end,
})

