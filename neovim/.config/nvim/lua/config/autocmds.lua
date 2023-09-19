local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local yank_group = augroup("HighLightYank", {})
local lsp_group = augroup("UserLspConfig", {})

local common_filetypes = {
    "*.c",
    "*.css",
    "*.html",
    "*.js",
    "*.jsx",
    "*.lua",
    "*.md",
    "*.py",
    "*.ts",
    "*.vala",
}

-- Highlight yanked text
autocmd("TextYankPost", {
    group = yank_group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            timeout = 120,
        })
    end,
})

-- Remove whitespace when saving a file
autocmd("BufWritePre", {
    pattern = common_filetypes,
    callback = function()
        -- Without moving the cursor
        vim.cmd([[normal mz]])
        vim.cmd([[%s/\s\+$//e]])
        vim.cmd([[normal `z]])
    end,
})

-- Add an empty new line at the end of a file, if one doesn't already exist
autocmd("BufWritePre", {
    pattern = common_filetypes,
    callback = function()
        local last_line_number = vim.fn.line("$")

        if vim.fn.getline(last_line_number) ~= "" then
            vim.fn.append(last_line_number, "")
        end
    end,
})

-- Use LspAttach autocommand to only map the following keys after the language
-- server attaches to the current buffer
autocmd("LspAttach", {
    group = lsp_group,
    callback = function(e)
        local opts = { buffer = e.buf }

        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    end,
})

