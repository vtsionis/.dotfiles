return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdateSync",
    event = {
        "BufReadPost",
        "BufNewFile",
    },
    dependencies = {
        -- Place here any plugins that depend on Treesitter
        "HiPhish/nvim-ts-rainbow2",
        "windwp/nvim-ts-autotag",
        "JoosepAlviste/nvim-ts-context-commentstring",
        "nvim-treesitter/playground",
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
            "html",
            "javascript",
            "json",
            "kotlin",
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
            "vue",
            "yaml",
            "zig",
        },
        sync_install = false,
        auto_install = true,

        -- Setup of Treesitter native modules
        -- see `:h nvim-treesitter-modules`
        -- Available plugins
        highlight = {
            enable = true,
        },

        -- Extra modules (listed in dependencies)
        rainbow = {
            enable = true,
        },
        autotag = {
            enable = true,
            filetypes = {
                "html",
                "javascript",
                "typescript",
                "javascriptreact",
                "typescriptreact",
                "svelte",
                "vue",
                "tsx",
                "jsx",
                "rescript",
                "xml",
                "php",
                "astro",
                "glimmer",
                "handlebars",
                "hbs",
            },
        },
        ts_context_commentstring = {
            enable = true,
            enable_autocmd = false,
        },
        playground = {
            enable = true,
        },
    },
    config = function(_, opts)
        -- Treesitter based folding
        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
        vim.opt.foldenable = false

        require("nvim-treesitter.configs").setup(opts)
    end,
}

