# Neovim Setup

## Prerequisites

- Clipboard tool

Install `xclip` via the OS package manager in order to have the `*` and `+`
registers working.

```
$ sudo pacman -S xclip
```

## Plugin Manager

Lazy.nvim (folke/lazy.nvim)

<span style="color:orange">NOTE: Run `:checkhealth <plugin_name>` after an installation to identify any potential issues.</span>

## Plugins

- Syntax Highlighting

Treesitter (nvim-treesitter/nvim-treesitter)

- Fuzzy Finder

Telescope (nvim-telescope/telescope.nvim)

- Keymaps displayer

Which-key (folke/which-key.nvim)

- Undo history

Telescope-undo.nvim (debugloop/telescope-undo.nvim)
This is used as a Telescope extension.

- LSP

Mason.nvim (williamboman/mason.nvim)
mason-lspconfig (williamboman/mason-lspconfig.nvim)
nvim-lspconfig (neovim/nvim-lspconfig)

TODO:
-- DAP
-- Linters
-- Formatters

-- on_attach()
```lua
require("lspconfig").gopls.setup({
    on_attach = function()
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = 0 })
        vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })

        vim.keymap.set("n", " r", vim.lsp.buf.rename, { buffer = 0 })

        vim.keymap.set("n", " df", vim.diagnostic.goto_next, { buffer = 0})
        vim.keymap.set("n", " db", vim.diagnostic.goto_prev, { buffer = 0})
        vim.keymap.set("n", " dl", "<cmd>Telescope diagnostics<CR>", { buffer = 0})
    end,
})
```
-- LSP autocomplete
hrsh7th/nvim-cmp

-- Snippets
TODO:

- Git integration

TODO:
tpope/vim-fugitive
lewis6991/gitsigns.nvim
kdheepak/lazygit.nvim

- Status Line

nvim-lualine/lualine.nvim

- File Explorer

TODO:

