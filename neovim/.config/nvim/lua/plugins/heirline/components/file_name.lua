local colors = require("utils.colors")

local conditions = require("heirline.conditions")

return {
    provider = function(self)
        local filename = vim.fn.fnamemodify(self.filename, ":.")
        if filename == "" then
            return "[No File]"
        end

        if not conditions.width_percent_below(#filename, 0.25) then
            filename = vim.fn.pathshorten(filename)
        end

        return filename
    end,

    hl = function()
        if conditions.is_active() then
            return { fg = colors.neon_blue, underline = true }
        end
        return { fg = colors.white }
    end,
}

