local colors = require("utils.colors")

local Space = { provider = " " }

return {
    {
        condition = function()
            return not vim.bo.modifiable or vim.bo.readonly
        end,

        provider = "",

        hl = { fg = colors.red },

        { Space },
    },
    {
        condition = function()
            return vim.bo.modified
        end,

        provider = "M",

        hl = { fg = colors.orange, italic = true },

        { Space },
    },
}

