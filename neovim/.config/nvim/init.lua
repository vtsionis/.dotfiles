local bootstrapper = require("bootstrapper")

-- Initialize options and package manager
bootstrapper.init()

-- Load configuration
bootstrapper.setup()

-- Temporarily until a message/notify plugin is installed
vim.opt.cmdheight = 1;

-- TODO:
-- 1. Port "SynthWave '84" theme from VSCode to Neovim
-- 2. Clear messages appearing below the status line after a certain period

