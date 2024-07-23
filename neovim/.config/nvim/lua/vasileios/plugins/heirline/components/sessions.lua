local colors = require("vasileios.globals.colors")

local get_current_session_name = function()
   local session = vim.v.this_session
   if not session then return "" end

   local file_name = session:match("^.+/(.+)$")
   if not file_name then return "" end

   local extension = file_name:match("^.+(%..+)$") or ""

   local fname_without_extension = file_name:gsub(extension:gsub("%.", "%%%.") .. "$", "")
   local fname_split = vim.split(fname_without_extension, "%%")

   return fname_split[#fname_split] or ""
end

return {
   condition = function(self)
      self.session_name = get_current_session_name()
      return self.session_name ~= ""
   end,

   hl = {
      fg = colors.silver,
   },

   provider = function(self)
      return "Session: " .. self.session_name
   end,
}

