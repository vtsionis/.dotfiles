local colors = require("utils.colors")

return {
    "rebelot/heirline.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "lewis6991/gitsigns.nvim",
    },
    event = "UiEnter",
    config = function()
        local config = require("plugins.heirline.config")

        local StatusLine = require("plugins.heirline.statusline")
        local Winbar = require("plugins.heirline.winbar")

        require("heirline").setup({
            statusline = {
                condition = function()
                    for _, disabled_filetype in pairs(config.disabled_filetypes) do
                        if vim.bo.filetype == disabled_filetype then
                            return false
                        end
                    end
                    return true
                end,

                hl = { bg = colors.black },

                StatusLine,
            },
            winbar = Winbar,
            opts = {
                disable_winbar_cb = function()
                    local filetype = vim.bo.filetype
                    for _, disabled_filetype in pairs(config.disabled_filetypes) do
                        if filetype == disabled_filetype then
                            return true
                        end
                    end
                end,
            },
        })
    end,
}

