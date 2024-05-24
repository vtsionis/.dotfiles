local colors = require("utils.colors")

return {
    update = {
        "WinNew",
        "WinClosed",
        "BufEnter",
    },

    provider = "%(%= 󰖭 %)",

    hl = { fg = colors.red, bg = colors.black },

    on_click = {
        name = "heirline_close_button",

        minwid = function()
            return vim.api.nvim_get_current_buf()
        end,

        callback = function(_, minwid)
            vim.api.nvim_buf_delete(minwid, { force = false })
        end,
    },
}

