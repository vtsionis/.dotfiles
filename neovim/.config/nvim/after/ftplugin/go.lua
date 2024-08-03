local options = {
   -- Make sure a hard tab is used
   expandtab = false,
   shiftwidth = 0,
   smarttab = false,
   softtabstop = 0,
}

for option, value in pairs(options) do
   vim.opt_local[option] = value
end

