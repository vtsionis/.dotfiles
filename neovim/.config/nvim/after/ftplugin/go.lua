-- go fmt doesn't expand tabs
-- in fact, it transforms spaces into a tab
local options = {
   expandtab = false,
   smarttab = false,
}

for option, value in pairs(options) do
   vim.opt_local[option] = value
end

