local options = {
   commentstring = "# %s",
}

for option, value in pairs(options) do
   vim.opt_local[option] = value
end

