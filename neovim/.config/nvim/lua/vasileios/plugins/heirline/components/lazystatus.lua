local colors = require("vasileios.globals.colors")

return {
    condition = require("lazy.status").has_updates,

    update = { "User", pattern = "LazyUpdate" },

    hl = { fg = colors.orange },

    on_click = {
       callback = function()
          require("lazy").update()
       end,
       name = "update_plugins",
    },

    provider = function()
        return require("lazy.status").updates()
    end,
}

