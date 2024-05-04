-- See `:help vim.keymap.set()`

local M = {}

-- Utility function to create a mapping
local function map(mode, lhs, rhs, options)
    options = options or {}
    options.silent = options.silent ~= false

    vim.keymap.set(mode, lhs, rhs, options)
end

M.setup = function()
    -- Disable the space key, since it will be used as the leader
    map({ "n", "v" }, "<Space>", "<Nop>")

    -- Disable arrow keys in normal mode
    map("n", "<Left>", "<Nop>")
    map("n", "<Right>", "<Nop>")
    map("n", "<Up>", "<Nop>")
    map("n", "<Down>", "<Nop>")

    -- Better up/down with wrapped lines
    map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
    map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

    -- Add undo break points
    map("i", ",", ",<C-g>u")
    map("i", ".", ".<C-g>u")
    map("i", "!", "!<C-g>u")
    map("i", "?", "?<C-g>u")
    map("i", ":", ":<C-g>u")
    map("i", ";", ";<C-g>u")

    -- Toggle list mode
    map("n", "<leader>l", ":set list!<CR>")

    -- Don't move the cursor when joining lines
    map("n", "J", "mzJ`z")

    -- Center cursor while moving around
    map("n", "<C-d>", "<C-d>zz")
    map("n", "<C-u>", "<C-u>zz")

    -- Center search results
    map("n", "n", "nzz")
    map("n", "N", "Nzz")

    -- Cancel search highlighting with ESC
    map("n", "<Esc>", "<cmd>nohlsearch<CR><Esc>")

    -- Move selected line / block of text
    map("n", "<M-j>", "<cmd>m .+1<CR>==")
    map("n", "<M-k>", "<cmd>m .-2<CR>==")
    map("v", "<M-j>", ":m '>+1<CR>gv=gv")
    map("v", "<M-k>", ":m '<-2<CR>gv=gv")

    -- Stay in indent mode
    map("v", "<", "<gv")
    map("v", ">", ">gv")

    -- Paste over currently selected text without yanking it
    map("v", "p", [["_dP]])

    -- Yank and paste to system clipboard
    local register = (vim.loop.os_uname().sysname == "Linux") and "+" or "*"
    map({ "n", "v" }, "<leader>y", [["]] .. register .. [[y]])
    map({ "n", "v" }, "<leader>d", [["]] .. register .. [[d]])
    map({ "n", "v" }, "<leader>p", [["]] .. register .. [[p]])
    map({ "n", "v" }, "<leader>P", [["]] .. register .. [[P]])

    -- Diagnostic keymaps
    map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
    map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
    map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
    map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

    -- Move to a window using the <ctrl> hjkl keys
    map("n", "<C-h>", "<C-w>h")
    map("n", "<C-l>", "<C-w>l")
    map("n", "<C-j>", "<C-w>j")
    map("n", "<C-k>", "<C-w>k")

    -- Cycle through open buffers
    map("n", "[b", ":bprevious<CR>")
    map("n", "]b", ":bnext<CR>")

    -- Buffer interactions
    map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save File" })
end

-- Specify keymaps for plugins
M.lsp = {}

return M;

