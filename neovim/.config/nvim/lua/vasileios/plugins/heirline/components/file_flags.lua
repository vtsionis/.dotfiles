local colors = require("vasileios.globals.colors")

local Space = require("vasileios.plugins.heirline.components.space")

return {
    {
        condition = function()
            return not vim.bo.modifiable or vim.bo.readonly
        end,

        hl = { fg = colors.red },

        provider = "",

        Space(),
    },
    {
        condition = function()
            return vim.bo.modified
        end,

        hl = { fg = colors.orange, italic = true },

        provider = "M",

        Space(),
    },
}

