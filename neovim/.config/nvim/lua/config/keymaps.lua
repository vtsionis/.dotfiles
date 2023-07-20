local wk_ok, wk = pcall(require, "which-key")

-- Utility function to create a mapping
local function map(mode, lhs, rhs, options, use_wk)
    options = options or {}
    options.silent = options.silent ~= false

    if use_wk and wk_ok then
        wk.register({
            [lhs] = { rhs, options.desc or "" },
        }, {
            mode = mode,
        })
    else
        vim.keymap.set(mode, lhs, rhs, options)
    end
end

--[===[
-- Exiting INSERT mode
map("i", "jk", "<Esc>")
map("i", "kj", "<Esc>")

-- Better up/down with wrapped lines
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Don't move the cursor when joining lines
map("n", "J", "mzJ`z")

-- Move to a window using the <ctrl> hjkl keys
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Center search results
map("n", "n", "nzz")
map("n", "N", "Nzz")

-- Cancel search highlighting with ESC
map("n", "<Esc>", ":nohlsearch<Bar>:echo<CR>")

-- Center cursor while moving around
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Disable the space key, since it will be used as the leader
map({ "n", "v" }, "<Space>", "<Nop>")

-- Yank and paste to system clipboard
local register = (vim.loop.os_uname().sysname == "Linux") and "+" or "*"
map({ "n", "v" }, "<leader>y", [["]] .. register .. [[y]])
map({ "n", "v" }, "<leader>d", [["]] .. register .. [[d]])
map({ "n", "v" }, "<leader>p", [["]] .. register .. [[p]])
map({ "n", "v" }, "<leader>P", [["]] .. register .. [[P]])

-- Resizing panes
map({ "n", "v" }, "<Up>", ":resize -1<CR>")
map({ "n", "v" }, "<Down>", ":resize +1<CR>")
map({ "n", "v" }, "<Left>", ":vertical resize +1<CR>")
map({ "n", "v" }, "<Right>", ":vertical resize -1<CR>")

-- Move selected line / block of text
map("n", "<M-j>", "<cmd>m .+1<CR>==")
map("n", "<M-k>", "<cmd>m .-2<CR>==")
map("v", "<M-j>", ":m '>+1<CR>gv=gv")
map("v", "<M-k>", ":m '<-2<CR>gv=gv")

-- Stay in ident mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Paste over currently selected text without yanking it
map("v", "p", [["_dP]])


-- Configure the below keymappings with the help of which-key when available
-- Select entire file
map("n", "<C-a>", "ggVG", { desc = "Select All" }, true)

-- Buffer interactions
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save File" }, true)
map("n", "<leader>x", "<cmd>bdelete<CR>", { desc = "Close buffer" }, true)
map("n", "<leader>q", "<cmd>qall<CR>", { desc = "Close All" }, true)

-- Special keymappings for installed plugins
-- Lazy
map("n", "<leader>l", "<cmd>Lazy<CR>", { desc = "Open Lazy" }, true)

-- Mason
map("n", "<leader>m", "<cmd>Mason<CR>", { desc = "Open Mason" }, true)

-- Telescope
local telescope_ok, telescope_builtin = pcall(require, "telescope.builtin")
if telescope_ok then
    map("n", "<leader>ff", telescope_builtin.find_files, { desc = "Find files" }, true)
    map("n", "<leader>fg", telescope_builtin.live_grep, { desc = "Live Grep" }, true)
    map("n", "<leader>fb", telescope_builtin.buffers, {}, true)
    map("n", "<leader>fh", telescope_builtin.help_tags, {}, true)
end

-- Nvim-tree
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle File Explorer" }, true)
--]===]

