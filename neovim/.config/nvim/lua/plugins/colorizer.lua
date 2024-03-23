return {
    -- for of "norcalli/nvim-colorizer.lua"
    "NvChad/nvim-colorizer.lua",
    ft = {
        "html",
        "css",
        "less",
        "sass",
        "scss",
    },
    config = function()
        require("colorizer").setup({
            user_default_options = {
                RRGGBBAA = true,
                AARRGGBB = true,
                css = true,
                mode = "virtualtext",
            }
        })
    end,
}

