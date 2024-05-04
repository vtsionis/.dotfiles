-- go fmt doesn't expand tabs
-- in fact, it transforms spaces into a tab
local options = {
    expandtab = false,
}

-- NOTE: set local options in ftplugin files
for option, value in pairs(options) do
    vim.opt_local[option] = value
end

