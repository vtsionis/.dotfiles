return {
    {
        "catppuccin/nvim",
        lazy = false,
        name = "catppuccin",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("catppuccin")
        end,
    },
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        priority = 1000,
        config = true,
    },
    {
        -- Plugin that enables the use of different color schemes per file type
        "folke/styler.nvim",
        event = "VeryLazy",
        config = function()
            require("styler").setup({
                themes = {
                    markdown = { colorscheme = "gruvbox" },
                },
            })
        end,
    },
}

