local VARIABLES = require("config.variables")

local ft_with_filename = {
    "help",
}

local config = {}

config.options = {
    theme = "dracula",
    section_separators = {
        left = "",
        right = "",
    },
    component_separators = {
        left = "",
        right = "|",
    },
    disabled_filetypes = {
        statusline = {
            "NvimTree",
        },
    },
}

config.sections = {
    -- Left
    lualine_a = {
        {
            "mode",
            fmt = function(mode)
                -- To keep the same width for the mode component regardless of
                -- the corresponding mode, we will keep the length of the mode
                -- equal to the longest desired length
                local padding = VARIABLES.MODE_MAX_LENGTH - string.len(mode)
                if padding > 0 then
                    return mode .. string.rep(" ", padding)
                end

                return mode
            end,
        },
    },
    -- TODO: check git diff icons
    lualine_b = {
        {
            "filename",
            --cond = function()
                -- Display the filename for names that are not fitted in the
                -- tab line
                --local filename = vim.fn.expand("%:t")
                --if string.len(filename) > VARIABLES.FILENAME_MAX_LENGTH then
                    --return true
                --end

                --local filetype = vim.opt.filetype:get()
                --for _, ft in pairs(ft_with_filename) do
                    --if ft == filetype then
                        -- Only display the filename for certain filetypes
                        --return true
                    --end
                --end
            --end,
        },
        "branch",
        "diff",
    },
    lualine_c = { "diagnostics" },

    -- Right
    lualine_x = {
        -- LSP diagnostics
    },
    lualine_y = {
        "filetype",
        {
            "encoding",
            cond = function()
                return vim.opt.fileencoding:get() ~= "utf-8"
            end,
        },
        {
            "fileformat",
            cond = function()
                return vim.bo.fileformat ~= "unix"
            end,
        },
    },
    lualine_z = { "progress", "location" },
}

return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
        require("lualine").setup(config)
    end,
}

