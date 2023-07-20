local function loaded_buffers()
    local buffers_counter = 0
    for _, buf_hndl in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf_hndl) then
            buffers_counter = buffers_counter + 1
        end
    end
    return buffers_counter
end

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local yank_group = augroup("HighLightYank", {})

local common_filetypes = {
    "*.c",
    "*.js",
    "*.lua",
    "*.py",
    "*.ts",
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

--[[
-- Close Neovim if the last loaded buffer was deleted
autocmd("BufDelete", {
    pattern = "*",
    callback = function()
        if loaded_buffers() == 1 then
            vim.cmd("q")
        end
    end,
})
--]]

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

