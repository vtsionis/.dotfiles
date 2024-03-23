-- See `:help lua-guide-autocommands`

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

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

local highlight_group = augroup("HighLightGroup", { clear = true })
local formatting_group = augroup("FormattingGroup", { clear = true })

-- Highlight yanked text
autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = highlight_group,
    group = augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank({
            timeout = 130,
        })
    end,
})

-- Remove whitespace when saving a file
autocmd("BufWritePre", {
    group = formatting_group,
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
    group = formatting_group,
    pattern = common_filetypes,
    callback = function()
        local last_line_number = vim.fn.line("$")

        if vim.fn.getline(last_line_number) ~= "" then
            vim.fn.append(last_line_number, "")
        end
    end,
})

