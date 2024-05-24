-- See `:help vim.keymap.set()`

local M = {}

-- Utility function to create a mapping
local function map(mode, lhs, rhs, options)
    options = options or {}
    options.silent = options.silent ~= false
    options.desc = options.desc or "which_key_ignore"

    vim.keymap.set(mode, lhs, rhs, options)
end

local function abbreviate(mode, lhs, rhs, options)
    if vim.fn.has("nvim-0.10") == 1 then
        map(mode, lhs, rhs, options)
    else
        mode = string.sub(mode, 1, 1)
        local command = ""
        if mode == "i" or mode == "c" then
            command = mode
        end
        command = command .. "ab"

        vim.cmd[command](lhs, rhs)
    end
end

M.setup = function()
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
    map("n", "<Esc>", function()
        vim.cmd.nohlsearch()
        vim.cmd.echo()
    end)

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
    -- map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
    -- map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

    -- Move to a window using the <ctrl> hjkl keys
    map("n", "<C-h>", "<C-w>h")
    map("n", "<C-l>", "<C-w>l")
    map("n", "<C-j>", "<C-w>j")
    map("n", "<C-k>", "<C-w>k")

    -- Cycle through open buffers
    map("n", "[b", ":bprevious<CR>")
    map("n", "]b", ":bnext<CR>")

    -- Toggle spell option
    map("n", "<leader><F4>", ":set spell!<CR>", { desc = "Toggle Spell Check"})

    -- Buffer interactions
    map("n", "<leader>w", "<cmd>w<CR>")

    -- Abbreviations
    -- "ia": insert mode
    -- "ca": cmdline mode
    -- "!a": both
    abbreviate("ia", "adn", "and")
    abbreviate("ia", "teh", "the")
end

-- Specify keymaps for plugins as a LazyKeysSpec table
M.nvim_tree = {
    { "<leader>ee", "<cmd>NvimTreeToggle<CR>", desc = "[E]xplorer [T]oggle" },
    { "<leader>ec", "<cmd>NvimTreeCollapse<CR>", desc = "[E]xplorer [C]ollapse" },
    { "<leader>er", "<cmd>NvimTreeRefresh<CR>", desc = "[E]xplorer [R]efresh" },
    { "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", desc = "[E]xplorer open at current [F]ile" },
}

M.telescope = {
    { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Telescope [F]ind [F]iles" },
    { "<leader>fw", "<cmd>Telescope grep_string<CR>", desc = "Telescope [F]ind [W]ord" },
    { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Telescope [F]ind with [G]rep" },
    { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Telescope [F]ind [B]uffers" },
}

M.auto_session = {
    { "<leader>ss", "<cmd>SessionSave<CR>", desc = "[S]ession [S]ave" },
    { "<leader>sr", "<cmd>SessionRestore<CR>", desc = "[S]ession [R]estore" },
    { "<leader>sf", "<cmd>Autosession search<CR>", desc = "[S]ession [F]ind" },
    { "<leader>sp", "<cmd>SessionPurgeOrphaned<CR>", desc = "[S]ession [P]urge Orphaned" },
}

return M;

