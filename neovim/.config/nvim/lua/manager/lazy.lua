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

vim.opt.runtimepath:prepend(lazypath)

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
        backdrop = 100,
        title = " Lazy Menu ",
        title_pos = "center",
        pills = true,
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
            require = " ",
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
    state = lazyroot .. "/lazy-state.json",
    dev = {
        path = "~/Software-Development/Neovim/plugins",
        fallback = false,
    },
})

