local HEIGHT_RATIO = 0.8
local WIDTH_RATIO = 0.5

return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    cmd = {
        "NvimTreeOpen",
        "NvimTreeToggle",
    },
    config = function()
        require("nvim-tree").setup({
            sort_by = "case_sensitive",
            sync_root_with_cwd = true,
            update_focused_file = {
                enable = true,
            },
            diagnostics = {
                enable = true,
                show_on_dirs = true,
                icons = {
                    hint = "",
                    info = "",
                    warning = "⚠",
                    error = "⊗",
                },
            },
            modified = {
                enable = true,
            },
            on_attach = function()
                local api = require("nvim-tree.api")

                local function edit_or_open()
                    local node = api.tree.get_node_under_cursor()

                    if node.nodes ~= nil then
                        -- Expand or collapse folder
                        api.node.open.edit()
                    else
                        -- Open file
                        api.node.open.edit()
                        -- Close the tree if file was opened
                        api.tree.close()
                    end
                end

                local function vsplit_preview()
                    local node = api.tree.get_node_under_cursor()

                    if node.nodes ~= nil then
                        -- Expand or collapse folder
                        api.node.open.edit()
                    else
                        -- Open file as vsplit
                        api.node.open.vertical()
                    end

                    -- Finally refocus on tree if it was lost
                    api.tree.focus()
                end

                -- Define keymaps
                vim.keymap.set("n", "l", edit_or_open, { desc = "Edit or Open", silent = true })
                vim.keymap.set("n", "L", vsplit_preview, { desc = "Vsplit Preview", silent = true })
                vim.keymap.set("n", "q", api.tree.close, { desc = "Close", silent = true })
                vim.keymap.set("n", "H", api.tree.collapse_all, { desc = "Collapse all", silent = true })
            end,
            view = {
                centralize_selection = true,
                width = function()
                    return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
                end,
                float = {
                    enable = true,
                    open_win_config = function()
                        local screen_w = vim.opt.columns:get()
                        local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
                        local window_w = screen_w * WIDTH_RATIO
                        local window_h = screen_h * HEIGHT_RATIO
                        local window_w_int = math.floor(window_w)
                        local window_h_int = math.floor(window_h)
                        local center_x = (screen_w - window_w) / 2
                        local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
                        return {
                            border = "rounded",
                            relative = "editor",
                            row = center_y,
                            col = center_x,
                            width = window_w_int,
                            height = window_h_int,
                        }
                    end,
                },
            },
            renderer = {
                add_trailing = true,
            },
        })
    end,
}

