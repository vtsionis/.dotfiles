local colors = require("vasileios.globals.colors")

local modes = {
   n = { name = "N", hl = { bg = colors.purple } },
   no = { name = "N(o)", hl = { bg = colors.purple } },
   nov = { name = "N(ov)", hl = { bg = colors.purple } },
   noV = { name = "N(oV)", hl = { bg = colors.purple } },
   ["no\22"] = { name = "N_", hl = { bg = colors.purple } },
   niI = { name = "Ni", hl = { bg = colors.purple } },
   niR = { name = "Nr", hl = { bg = colors.purple } },
   niV = { name = "Nv", hl = { bg = colors.purple } },

   nt = { name = "NT", hl = { bg = colors.cyan } },
   ntT = { name = "NT(ntT)", hl = { bg = colors.cyan } },

   v = { name = "V", hl = { bg = colors.yellow } },
   vs = { name = "V-S", hl = { bg = colors.yellow } },
   V = { name = "V-L", hl = { bg = colors.yellow } },
   Vs = { name = "VL-S", hl = { bg = colors.yellow } },
   ["\22"] = { name = "V-B", hl = { bg = colors.yellow } },
   ["\22s"] = { name = "VB-S", hl = { bg = colors.yellow } },
   s = { name = "S", hl = { bg = colors.yellow } },
   S = { name = "S-L", hl = { bg = colors.yellow } },
   ["\19"] = { name = "S-B", hl = { bg = colors.yellow } },

   i = { name = "I", hl = { bg = colors.green } },
   ic = { name = "I", hl = { bg = colors.green } },
   ix = { name = "I", hl = { bg = colors.green } },

   R = { name = "R", hl = { bg = colors.red } },
   Rc = { name = "R(c)", hl = { bg = colors.red } },
   Rx = { name = "R(x)", hl = { bg = colors.red } },
   Rv = { name = "V-R", hl = { bg = colors.red } },
   Rvc = { name = "V-R(c)", hl = { bg = colors.red } },
   fvx = { name = "V-R(x)", hl = { bg = colors.red } },

   c = { name = "C", hl = { bg = colors.orange } },
   cv = { name = "C Ex", hl = { bg = colors.orange } },

   r = { name = "Prompt", hl = { bg = colors.bright_orange } },
   rm = { name = "More", hl = { bg = colors.bright_orange } },
   ["r?"] = { name = "Confirm", hl = { bg = colors.bright_orange } },
   ["!"] = { name = "Shell", hl = { bg = colors.bright_orange } },

   t = { name = "T", hl = { bg = colors.blue } },
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
      return "%-02( " .. self.mode.name .. "%) "
   end,
}

