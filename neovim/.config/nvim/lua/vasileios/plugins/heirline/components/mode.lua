local colors = require("vasileios.globals.colors")

local modes = {
   n = { name = "Normal", hl = { bg = colors.purple } },
   no = { name = "Normal (no)", hl = { bg = colors.purple } },
   nov = { name = "Normal (nov)", hl = { bg = colors.purple } },
   noV = { name = "Normal (noV)", hl = { bg = colors.purple } },
   ["no\22"] = { name = "Normal_", hl = { bg = colors.purple } },
   niI = { name = "Normal i", hl = { bg = colors.purple } },
   niR = { name = "Normal r", hl = { bg = colors.purple } },
   niV = { name = "Normal v", hl = { bg = colors.purple } },

   nt = { name = "NTerminal", hl = { bg = colors.cyan } },
   ntT = { name = "NTerminal (ntT)", hl = { bg = colors.cyan } },

   v = { name = "Visual", hl = { bg = colors.yellow } },
   vs = { name = "V-Select", hl = { bg = colors.yellow } },
   V = { name = "V-Line", hl = { bg = colors.yellow } },
   Vs = { name = "VL-Select", hl = { bg = colors.yellow } },
   ["\22"] = { name = "V-Block", hl = { bg = colors.yellow } },
   ["\22s"] = { name = "VB-Select", hl = { bg = colors.yellow } },
   s = { name = "Select", hl = { bg = colors.yellow } },
   S = { name = "S-Line", hl = { bg = colors.yellow } },
   ["\19"] = { name = "S-Block", hl = { bg = colors.yellow } },

   i = { name = "Insert", hl = { bg = colors.green } },
   ic = { name = "Insert", hl = { bg = colors.green } },
   ix = { name = "Insert", hl = { bg = colors.green } },

   R = { name = "Replace", hl = { bg = colors.red } },
   Rc = { name = "Replace (Rc)", hl = { bg = colors.red } },
   Rx = { name = "Replace (Rx)", hl = { bg = colors.red } },
   Rv = { name = "V-Replace", hl = { bg = colors.red } },
   Rvc = { name = "V-Replace (Rc)", hl = { bg = colors.red } },
   fvx = { name = "V-Replace (Rx)", hl = { bg = colors.red } },

   c = { name = "Command", hl = { bg = colors.orange } },
   cv = { name = "Command Ex", hl = { bg = colors.orange } },

   r = { name = "Prompt", hl = { bg = colors.bright_orange } },
   rm = { name = "More", hl = { bg = colors.bright_orange } },
   ["r?"] = { name = "Confirm", hl = { bg = colors.bright_orange } },
   ["!"] = { name = "Shell", hl = { bg = colors.bright_orange } },

   t = { name = "Terminal", hl = { bg = colors.blue } },
}

local default_settings = {
   fg = colors.black,
   bold = true,
}

return {
   update = {
      "ModeChanged",
      pattern = "*:*",
      callback = vim.schedule_wrap(function()
         vim.cmd("redrawstatus")
      end),
   },

   init = function(self)
      local code = vim.api.nvim_get_mode().mode or ""
      local mode_properties = modes[code] or {}

      self.mode = {
         code = code,
         name = mode_properties.name or "",
         hl = mode_properties.hl or {},
      }
   end,

   hl = function(self)
      return vim.tbl_extend("force", default_settings, self.mode.hl)
   end,

   provider = function(self)
      return "%-09( " .. self.mode.name .. "%)"
   end,
}

