local extensions = {
    fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
    },
}

return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.1",
    cmd = "Telescope",
    dependencies = {
        -- Required dependencies
        "nvim-lua/plenary.nvim",

        -- Suggested dependencies
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
    },
    config = function()
        local telescope_ok, telescope = pcall(require, "telescope")
        if not telescope_ok then return end

        telescope.setup({
            extensions = extensions,
        })

        for extension in pairs(extensions) do
            telescope.load_extension(extension)
        end
    end,
}

