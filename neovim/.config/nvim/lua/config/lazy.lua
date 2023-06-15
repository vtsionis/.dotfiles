-- Install lazy.nvim
local lazyroot = vim.fn.stdpath "data" .. "/lazy"
local lazypath = lazyroot .. "/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
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
        border = "single",
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
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
    state = lazyroot .. "/lazy-state.json",
})

