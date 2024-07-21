local options = {
   expandtab = true,
   shiftwidth = 2,
   softtabstop = 2,
   tabstop = 2,
}

for option, value in pairs(options) do
   vim.opt_local[option] = value
end

