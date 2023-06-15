local VARIABLES = require("config.variables")

return {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    version = "*",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local bufferline = require("bufferline")

        -- Modify the highlight group of TabLineSel to stylish the underline
        -- indicator
        vim.api.nvim_set_hl(0, "TabLineSel", {
            fg = "#34D8F1",
            bold = true,
            standout = true,
        })

        bufferline.setup({
            options = {
                style_preset = {
                    bufferline.style_preset.no_italic,
                    bufferline.style_preset.no_bold,
                },
                indicator = {
                    style = "underline",
                },
                max_name_length = VARIABLES.FILENAME_MAX_LENGTH,
                tab_size = 10,
                diagnostics = "nvim_lsp",
                hover = {
                    enabled = true,
                    delay = 200,
                    reveal = { "close" },
                },
                sort_by = "insert_after_current",
            },
        })
    end,
}

