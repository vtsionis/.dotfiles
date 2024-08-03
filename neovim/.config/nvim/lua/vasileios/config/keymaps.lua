-- See `:help vim.keymap.set()`

local M = {}

local map = function(mode, lhs, rhs, options)
   options = options or {}
   options.silent = options.silent ~= false
   options.desc = options.desc or "which_key_ignore"

   vim.keymap.set(mode, lhs, rhs, options)
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
   map("n", "<leader>l", "<cmd>set list!<CR>")

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

   -- Paste over currently selected text without yanking it
   map("v", "p", [["_dP]])

   -- Yank and paste to system clipboard
   local register = (vim.uv.os_uname().sysname == "Linux") and "+" or "*"
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
   map("n", "[b", "<cmd>bprevious<CR>")
   map("n", "]b", "<cmd>bnext<CR>")

   -- Cycle through open tabs
   map("n", "[t", "<cmd>tabprevious<CR>")
   map("n", "]t", "<cmd>tabnext<CR>")

   -- Toggle spell option
   map("n", "<leader><F4>", "<cmd>set spell!<CR>", { desc = "Toggle Spell Check"})

   -- Buffer interactions
   map("n", "<leader>w", "<cmd>w<CR>")

   -- Move in and out of a terminal window
   map("t", "<C-h>", "<cmd>wincmd h<CR>")
   map("t", "<C-l>", "<cmd>wincmd l<CR>")
   map("t", "<C-j>", "<cmd>wincmd j<CR>")
   map("t", "<C-k>", "<cmd>wincmd k<CR>")

   -- Abbreviations
   -- "ia": insert mode
   -- "ca": cmdline mode
   -- "!a": both
   map("ia", "adn", "and")
   map("ia", "teh", "the")
end

-- Specify keymaps for plugins as a LazyKeysSpec table
-- see: https://lazy.folke.io/spec/lazy_loading#%EF%B8%8F-lazy-key-mappings
M.auto_session = {
   { "<leader>ss", ":SessionSave ", desc = "[S]ession [S]ave (name)" },
   { "<leader>sr", "<cmd>SessionRestore<CR>", desc = "[S]ession [R]estore" },
   { "<leader>sf", "<cmd>Telescope session-lens<CR>", desc = "[S]ession [F]ind" },
}

M.gitsigns = {
   { "]g", function()
      require("gitsigns").nav_hunk("next")
   end, desc = "Next [g]it hunk" },
   { "[g", function()
      require("gitsigns").nav_hunk("prev")
   end, desc = "Previous [g]it [h]unk" },
   { "<leader>gp", function()
      require("gitsigns").preview_hunk_inline()
   end, desc = "[g]it hunk [p]review" },
   { "<leader>gP", function()
      require("gitsigns").preview_hunk()
   end, desc = "[g]it hunk [P]review (floating)" },
   { "<leader>gr", function()
      require("gitsigns").reset_hunk()
   end, desc = "[g]it hunk [r]eset" },
   { "<leader>gr", function()
      require("gitsigns").reset_hunk({
         vim.fn.line("."),
         vim.fn.line("v"),
      })
   end, mode = "v", desc = "[g]it hunk [r]eset" },
}

M.oil = {
   { "-", "<cmd>Oil<CR>", desc = "Open parent directory" },
}

M.nvim_tree = {
   { "<leader>e", "<cmd>NvimTreeToggle<CR>" },
}

M.nvim_ufo = {
   { "zR", function()
      require("ufo").openAllFolds()
   end, desc = "Open All Folds" },
   { "zM", function()
      require("ufo").closeAllFolds()
   end, desc = "Close All Folds" },
   { "zr", function()
      require("ufo").openFoldsExceptKinds()
   end, desc = "Open Folds Except Kinds" },
   { "zm", function()
      require("ufo").closeFoldsWith()
   end, desc = "Close Folds With" },
   { "zK", function()
      require("ufo").peekFoldedLinesUnderCursor()
   end, desc = "Peek Folded Lines Under Cursor" },
}

M.treesitter_context = {
   { "[c", function()
      require("treesitter-context").go_to_context(vim.v.count1)
   end, desc = "Go to context" },
}

M.toggleterm = {
   { [[<C-\>]], "<cmd>ToggleTerm direction='float'<CR>", mode = { "n", "t" }, desc = "Toggle Terminal (float)" },
   { [[<C-`>]], "<cmd>ToggleTerm direction='horizontal'<CR>", mode = { "n", "t" }, desc = "Toggle Terminal (horizontal)" },
}

M.telescope = {
   { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Telescope [F]ind [F]iles" },
   { "<leader>fw", "<cmd>Telescope grep_string<CR>", desc = "Telescope [F]ind [W]ord" },
   { "<leader>/", "<cmd>Telescope live_grep<CR>", desc = "Telescope [F]ind with [G]rep" },
   { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Telescope [F]ind [B]uffers" },
}

return M;

