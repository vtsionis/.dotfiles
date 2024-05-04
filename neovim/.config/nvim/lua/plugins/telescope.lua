return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    event = "VimEnter",
    dependencies = {
        -- Required
        "nvim-lua/plenary.nvim",

        -- Suggested
        "BurntSushi/ripgrep",

        -- Optional
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local actions = require("telescope.actions")
        local action_layout = require("telescope.actions.layout")

        require("telescope").setup({
            defaults = {
                mappings = {
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
        })
    end,
}

