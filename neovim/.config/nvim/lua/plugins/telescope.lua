local keys = require("config.keymaps").telescope

return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    event = "VimEnter",
    dependencies = {
        -- Required
        "nvim-lua/plenary.nvim",

        -- Suggested
        "BurntSushi/ripgrep",
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        "nvim-telescope/telescope-ui-select.nvim",

        -- Optional
        "nvim-tree/nvim-web-devicons",
    },
    keys = keys or {},
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local action_layout = require("telescope.actions.layout")
        local themes = require("telescope.themes")

        local extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "respect_case",
            },
            ["ui-select"] = {
                themes.get_dropdown(),
            },
        }

        telescope.setup({
            defaults = {
                wrap_results = true,
                path_display = { "smart" },
                mappings = {
                    n = {
                        ["<M-p>"] = action_layout.toggle_preview,
                    },
                    i = {
                        ["<Esc>"] = actions.close,
                        ["<C-u>"] = false,
                        ["<M-p>"] = action_layout.toggle_preview,
                    },
                },
            },

            pickers = {
                buffers = {
                    mappings = {
                        i = {
                            ["<C-d>"] = actions.delete_buffer + actions.move_to_top,
                        },
                    },
                },
            },

            extensions = extensions,
        })

        for extension in pairs(extensions) do
            telescope.load_extension(extension)
        end
    end,
}

