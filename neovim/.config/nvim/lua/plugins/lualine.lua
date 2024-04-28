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
    ignore_focus = {
        "lazy",
        "mason",
        "TelescopePrompt",
    },
}

config.sections = {
    -- Left
    lualine_a = {
        "mode",
    },
    -- TODO: check git diff icons
    lualine_b = {
        "filename",
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
    lualine_z = {
        "searchcount",
        "progress",
        "location",
    },
}

config.winbar = {
    lualine_c = { "filename" },
}

config.inactive_winbar = {
    lualine_c = { "filename" },
}

return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
        require("lualine").setup(config)
    end,
}

