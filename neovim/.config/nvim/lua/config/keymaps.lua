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

-- Disable the space key, since it will be used as the leader
map({ "n", "v" }, "<Space>", "<Nop>")

-- Exiting INSERT mode
map("i", "jk", "<Esc>")
map("i", "kj", "<Esc>")

-- Better up/down with wrapped lines
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Don't move the cursor when joining lines
map("n", "J", "mzJ`z")

-- Center cursor while moving around
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Center search results
map("n", "n", "nzz")
map("n", "N", "Nzz")

-- Cancel search highlighting with ESC
map("n", "<Esc>", ":nohlsearch<Bar>:echo<CR>")

-- Move to a window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

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

-- Resizing panes
map({ "n", "v" }, "<Up>", ":resize -1<CR>")
map({ "n", "v" }, "<Down>", ":resize +1<CR>")
map({ "n", "v" }, "<Left>", ":vertical resize +1<CR>")
map({ "n", "v" }, "<Right>", ":vertical resize -1<CR>")

--------------------------------------------------------------------------------
-- Configure the below keymappings with the help of which-key when available

-- Buffer interactions
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save File" }, true)

--[===[
-- Special keymappings for installed plugins
-- Lazy
map("n", "<leader>l", "<cmd>Lazy<CR>", { desc = "Open Lazy" }, true)

-- Mason
map("n", "<leader>m", "<cmd>Mason<CR>", { desc = "Open Mason" }, true)

-- Nvim-tree
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle File Explorer" }, true)
--]===]

-- Telescope
local telescope_ok, telescope_builtin = pcall(require, "telescope.builtin")
if telescope_ok then
    if wk_ok then
        wk.register({
            f = {
                name = "Telescope",
                f = { telescope_builtin.find_files, "Find files" },
                g = { telescope_builtin.git_files, "Find git files" },
                l = { telescope_builtin.live_grep, "Live Grep" },
                b = { telescope_builtin.buffers, "Find buffers" },
                h = { telescope_builtin.help_tags, "Find help tags" },
            },
        }, { prefix = "<leader>" })
    else
        map("n", "<leader>ff", telescope_builtin.find_files, { desc = "Find files | Telescope" })
        map("n", "<leader>fg", telescope_builtin.git_files, { desc = "Find git files | Telescope" })
        map("n", "<leader>fl", telescope_builtin.live_grep, { desc = "Live Grep | Telescope" })
        map("n", "<leader>fb", telescope_builtin.buffers, { desc = "Find buffers | Telescope" })
        map("n", "<leader>fh", telescope_builtin.help_tags, { desc = "Find help tags | Telescope" })
    end
end

-- Undotree
local undotree_ok, undotree = pcall(require, "undotree")
if undotree_ok then
    map("n", "<leader>u", undotree.toggle, { desc = "Toggle undo tree | Undotree" }, true)
end

