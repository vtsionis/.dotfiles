local options = {
    expandtab = true,
    shiftwidth = 2,
    softtabstop = 2,
    tabstop = 2,
}

-- NOTE: set local options in ftplugin files
for option, value in pairs(options) do
    vim.opt_local[option] = value
end

