-- See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim

local lazyroot = vim.fn.stdpath("data") .. "/lazy"
local lazypath = lazyroot .. "/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

-- Configure lazy.nvim
require("lazy").setup("plugins", {
    root = lazyroot,
    defaults = {
        lazy = true,
    },
    lockfile = lazyroot .. "/lazy-lock.json",
    install = {
        missing = true,
        colorscheme = { "catppuccin", "habamax" },
    },
    ui = {
        size = {
            width = 0.85,
            height = 0.85,
        },
        wrap = true,
        border = "rounded",
        icons = {
            cmd = " ",
            config = "",
            event = "",
            ft = " ",
            init = " ",
            import = " ",
            keys = " ",
            lazy = "󰒲 ",
            loaded = "●",
            not_loaded = "○",
            plugin = " ",
            runtime = " ",
            source = " ",
            start = "",
            task = "✔ ",
            list = {
                "●",
                "➜",
                "★",
                "‒",
            },
        },
    },
    checker = {
        enabled = true,
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "matchit",
                "matchparen",
                -- "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
    state = lazyroot .. "/lazy-state.json",
})

