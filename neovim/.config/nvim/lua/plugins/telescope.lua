local extensions = {
    fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
    },
    undo = {
        use_delta = true,
        side_by_side = true,
    },
}

return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    cmd = "Telescope",
    dependencies = {
        -- Required dependencies
        "nvim-lua/plenary.nvim",

        -- Suggested dependencies
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
        "debugloop/telescope-undo.nvim",
    },
    config = function()
        local ok, telescope = pcall(require, "telescope")
        if not ok then return end

        telescope.setup({
            defaults = {
                layout_strategy = "horizontal",
                layout_config = {
                    width = {
                        padding = 3,
                    },
                    height = 0.9,
                    preview_cutoff = 20,
                    preview_width = 0.7,
                },
            },
            extensions = extensions,
        })

        for extension in pairs(extensions) do
            telescope.load_extension(extension)
        end
    end,
}

