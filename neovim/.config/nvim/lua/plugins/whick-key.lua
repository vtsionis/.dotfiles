return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        spelling = {
            enabled = false,
        },
        presets = {
            operators = false,
            motions = false,
            text_objects = false,
            windows = false,
            nav = false,
            z = false,
            g = false,
        },
        window = {
            border = "rounded",
            padding = { 1, 1, 1, 1 },
        },
        triggers = {
            "<leader>",
        },
    },
}

