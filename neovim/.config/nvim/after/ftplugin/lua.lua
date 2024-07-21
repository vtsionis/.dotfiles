local options = {
   expandtab = true,
   shiftwidth = 3,
   softtabstop = 3,
   tabstop = 3,
}

for option, value in pairs(options) do
   vim.opt_local[option] = value
end

