local colors = require("utils.colors")

local utils = require("heirline.utils")

local separators = require("plugins.heirline.config").separators

return {
    init = function(self)
        local encoding = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc
        local format = vim.bo.fileformat

        self.result = ""
        if encoding ~= "utf-8" then
            self.result = encoding
        end
        if format ~= "unix" then
            if #self.result > 0 then
                self.result = self.result .. " | " .. format
            else
                self.result = format
            end
        end
    end,

    hl = { fg = colors.black, bold = true },

    {
        condition = function(self)
            print(self.result)
            return #self.result > 0
        end,

        {
            provider = " ",

            utils.surround({
                separators.bubble_left,
                separators.bubble_right,
            }, colors.yellow, {
                provider = function(self)
                    return self.result:upper()
                end,
            })
        },
    },
}

