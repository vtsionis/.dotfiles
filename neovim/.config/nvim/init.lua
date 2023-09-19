require("config.options")
require("config.lazy")

vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
        require("config.keymaps")
        require("config.autocmds")

        -- Load custom highlights after the color scheme is set so it will not
        -- overwrite them
        require("config.highlights")
    end,
})

