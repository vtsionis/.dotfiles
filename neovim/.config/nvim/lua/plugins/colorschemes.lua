return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        lazy = false,
        config = function()
            vim.cmd.colorscheme("catppuccin")
        end,
    },
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        lazy = false,
        config = true,
    },
    {
        "Mofiqul/dracula.nvim",
        priority = 1000,
        lazy = false,
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

