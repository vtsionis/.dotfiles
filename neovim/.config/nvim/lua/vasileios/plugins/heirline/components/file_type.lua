local disabled_filetypes = require("vasileios.plugins.heirline.globals").disabled_filetypes

return {
    condition = function()
        for _, filetype in pairs(disabled_filetypes) do
            if vim.bo.filetype == filetype then
                return false
            end
        end
        return true
    end,

    init = function(self)
       self.filetype = vim.bo.filetype
    end,

    provider = function(self)
       return self.filetype
    end,
}

