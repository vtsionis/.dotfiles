-- See `:help vim.opt`
-- For more options, you can see `:help option-list`

local opt = vim.opt

-- Specify Global options
local goptions = {
  -- Specify the leader keys
  mapleader = " ",
  maplocalleader = " ",

  -- Disable builtin plugins
  loaded_2html_plugin = 1,
  loaded_gzip = 1,
  loaded_matchit = 1,
  loaded_matchparen = 1,
  loaded_netrwPlugin = 1,
  loaded_tarPlugin = 1,
  loaded_tutor_mode_plugin = 1,
  loaded_zipPlugin = 1,

  -- Disable all providers for remote plugins
  -- see :help remote-plugin
  loaded_python3_provider = 0,
  loaded_ruby_provider = 0,
  loaded_node_provider = 0,
  loaded_perl_provider = 0,

  -- Fix markdown indentation settings
  markdown_recommended_style = 0,

  -- Skip backwards compatibility routines and speed up loading for Treesitter's
  -- "JoosepAlviste/nvim-ts-context-commentstring" plugin
  skip_ts_context_commentstring_module = true,
}

-- Specify Local options
local options = {
  breakindent = true,
  cdhome = true,
  clipboard = "unnamedplus",
  cmdheight = 0,
  cmdwinheight = 10,
  colorcolumn = "80",
  completeopt = "menu,menuone,preview,noselect",
  conceallevel = 3,
  confirm = true,
  cpoptions = opt.cpoptions._value .. "n",
  cursorline = true,
  expandtab = true,
  fillchars = {
      eob = ' ',
      fold = " ",
      foldopen = "⌄",
      foldclose = "󰥭",
      foldsep = " ",
      horiz = '━',
      horizup = '┻',
      horizdown = '┳',
      vert = '┃',
      vertleft = '┫',
      vertright = '┣',
      verthoriz = '╋',
  },
  foldcolumn = "1",
  foldenable = true,
  foldlevel = 99,
  foldlevelstart = 99,
  formatoptions = "jcroqlnt",
  hlsearch = true,
  inccommand = "split",
  ignorecase = false,
  jumpoptions = { "stack" },
  keymodel = "startsel",
  laststatus = 3,
  linebreak = true,
  list = false,
  listchars = {
      eol = "⤶",
      lead = "␣",
      nbsp = "␣",
      space = "␣",
      tab = "  󰌒",
      trail = "␣",
  },
  mouse = "a",
  mousemoveevent = true,
  number = true,
  numberwidth = 3,
  path = ".,/usr/include/,,,*,**",
  pumblend = 0,
  pumheight = 15,
  relativenumber = true,
  report = 0,
  scroll = 0,
  scrolloff = 10,
  sessionoptions = {
      "blank",
      "buffers",
      "curdir",
      "folds",
      "help",
      "tabpages",
      "winsize",
      "winpos",
      "terminal",
      "localoptions",
  },
  shiftround = true,
  shiftwidth = 4,
  shortmess = opt.shortmess._value .. "mrsWIcC",
  showcmd = false,
  showmode = false,
  showtabline = 0,
  sidescrolloff = 8,
  signcolumn = "yes",
  smartcase = true,
  smartindent = true,
  softtabstop = 4,
  spell = false,
  spellfile = vim.fs.dirname(os.getenv("MYVIMRC")) .. "/spell/words.add",
  spelllang = { "en" },
  spelloptions = "camel",
  splitbelow = true,
  splitkeep = "screen",
  splitright = true,
  statusline = "",
  swapfile = false,
  tabstop = 4,
  termguicolors = true,
  timeout = true,
  timeoutlen = 300,
  title = true,
  titlestring = "%F %r %m",
  undofile = true,
  undolevels = 10000,
  updatetime = 250,
  visualbell = true,
  wildignore = {
      "**/.git/*",
      "**/node_modules/*",
  },
  wildmode = "longest:full,full",
  winminwidth = 5,
  wrap = true,
}

-- Finally, set all above options via a for loop
for option, value in pairs(goptions) do
  vim.g[option] = value
end

for option, value in pairs(options) do
  vim.opt[option] = value
end

