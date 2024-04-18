local options = {
    colorcolumn = "79",
    expandtab = true,
    shiftwidth = 4,
    softtabstop = 4,
    tabstop = 4,
}

-- NOTE: set local options in ftplugin files
for option, value in pairs(options) do
    vim.opt_local[option] = value
end

