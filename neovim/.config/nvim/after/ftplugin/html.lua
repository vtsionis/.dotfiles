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

-- When the cursor is between an opening and a closing tag, move it to a new
-- empty line while the closing tag is moved one line below, upon hitting Enter
vim.keymap.set("i", "<CR>", function()
    local current_line = vim.fn.getline(".")
    local column = vim.fn.getpos(".")[3]

    local before = string.sub(current_line, column - 1, column - 1)
    local after = string.sub(current_line, column, column)

    if before == ">" and after == "<" then
        return "<CR><C-o>O"
    end

    return "<CR>"
end, { expr = true })

