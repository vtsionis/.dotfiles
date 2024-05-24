local colors = require("utils.colors")

return {
    condition = require("lazy.status").has_updates,

    update = { "User", pattern = "LazyUpdate" },

    provider = function()
        return require("lazy.status").updates()
    end,

    on_click = {
        callback = function()
            require("lazy").update()
        end,
        name = "update_plugins",
    },

    hl = { fg = colors.orange },
}

