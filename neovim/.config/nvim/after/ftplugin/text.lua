local options = {
   spell = false,
}

for option, value in pairs(options) do
   vim.opt_local[option] = value
end

