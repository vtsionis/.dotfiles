local filetypes = {
    "html",
    "css",
    "less",
    "sass",
    "scss",
}

local event = {}
for _, filetype in pairs(filetypes) do
    table.insert(event, "BufEnter *." .. filetype)
end

return {
    "norcalli/nvim-colorizer.lua",
    event = event,
    config = function()
        vim.api.nvim_create_autocmd("FileType", {
            pattern = filetypes,
            command = vim.cmd([[ColorizerAttachToBuffer]]),
        })
    end,
}

