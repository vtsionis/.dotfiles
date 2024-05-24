local config = require("plugins.heirline.config")

return {
    condition = function()
        for _, disabled_filetype in pairs(config.disabled_filetypes) do
            if vim.bo.filetype == disabled_filetype then
                return false
            end
        end
        return true
    end,

    provider = vim.bo.filetype,
}

