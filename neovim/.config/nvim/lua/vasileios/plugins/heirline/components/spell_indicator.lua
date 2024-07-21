local colors = require("vasileios.globals.colors")

return {
    hl = function()
        if vim.wo.spell then
            return { fg = colors.green }
        end

        return { fg = colors.bright_grey }
    end,

    on_click = {
        name = "heirline_spell_indicator",

        callback = function()
           vim.cmd.set("spell!")
        end,
    },

    provider = function()
        return "Spell 󰓆"
    end,
}

