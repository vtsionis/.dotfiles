require("config.options")
require("config.lazy")

vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
        require("config.keymaps")
        require("config.autocmds")

        -- Load custom highlights after the color scheme is set so they will not
        -- get overwritten by the color scheme
        require("config.highlights")
    end,
})

-- TODO:
-- 1. Port "SynthWave '84" theme from VSCode to Neovim

