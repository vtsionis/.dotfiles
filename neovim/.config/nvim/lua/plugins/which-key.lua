return {
    "folke/which-key.nvim",
    lazy = true,
    config = function()
        vim.opt.timeout = true
        vim.opt.timeoutlen = 501
        require("which-key").setup({
            plugins = {
                marks = false,
                registers = false,

                presets = {
                    operators = false,
                    motions = false,
                    text_objects = false,
                    windows = false,
                    nav = false,
                },
            },

            -- Hide mappings that were not explicitly registered
            ignore_missing = true,
        })
    end,
}

