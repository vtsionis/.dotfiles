return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdateSync",
    event = {
        "BufReadPost",
        "BufNewFile",
    },
    dependencies = {
        -- Extra modules
        "HiPhish/rainbow-delimiters.nvim",
        {
            "windwp/nvim-ts-autotag",
            ft = {
                "astro",
                "glimmer",
                "handlebars",
                "hbs",
                "html",
                "javascript",
                "javascriptreact",
                "jsx",
                "php",
                "rescript",
                "svelte",
                "tsx",
                "typescript",
                "typescriptreact",
                "vue",
                "xml",
            },
            config = true,
        },
        {
            "JoosepAlviste/nvim-ts-context-commentstring",
            lazy = false,
            config = function()
                vim.g.skip_ts_context_commentstring_module = true

                require("ts_context_commentstring").setup({
                    enable_autocmd = false,
                })
            end,
        },
    },
    cmd = {
        "TSInstall",
        "TSBufEnable",
        "TSBufDisable",
        "TSModuleInfo",
    },
    opts = {
        ensure_installed = {
            "bash",
            "c",
            "cmake",
            "css",
            "diff",
            "go",
            "html",
            "javascript",
            "json",
            "lua",
            "make",
            "markdown",
            "markdown_inline",
            "python",
            "query",
            "regex",
            "rust",
            "sql",
            "svelte",
            "toml",
            "tsx",
            "typescript",
            "vala",
            "vim",
            "vimdoc",
            "yaml",
        },
        sync_install = false,
        auto_install = true,

        -- Setup of Treesitter native modules
        -- see `:h nvim-treesitter-modules`
        -- Available plugins
        highlight = {
            enable = true,
        },
    },
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end,
}

