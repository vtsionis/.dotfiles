local keys = require("config.keymaps").nvim_tree

return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    keys = keys or {},
    config = function()
        require("nvim-tree").setup({
            sort = {
                sorter = "name",
                folders_first = true,
            },

            view = {
                number = true,
                relativenumber = true,
                width = {
                    min = "80%",
                    padding = 5,
                },
                float = {
                    enable = true,
                    open_win_config = {
                        relative = "editor",
                        border = "rounded",
                        title = " File Explorer ",
                        title_pos = "center",
                    },
                },
            },

            renderer = {
                full_name = true,
                special_files = {},
                indent_markers = {
                    enable = true,
                    icons = {
                        corner = "└",
                        edge = "┆ ",
                        item = "┆ ",
                        bottom = "─",
                        none = " ",
                    },
                },
                icons = {
                    git_placement = "after",
                    glyphs = {
                        folder = {
                            arrow_closed = "󰥭",
                            arrow_open = "⌄",
                        },
                        git = {
                            unstaged = "M",
                            staged = "S",
                            renamed = "R",
                            untracked = "N",
                            deleted = "D",
                        },
                    },
                },
            },

            update_focused_file = {
                enable = true,
            },

            diagnostics = {
                enable = true,
                show_on_dirs = true,
            },

            filters = {
                exclude = {
                    ".DS_Store",
                },
            },

            ui = {
                confirm = {
                    remove = false,
                    trash = false,
                    default_yes = true,
                },
            },
        })
    end,
}

