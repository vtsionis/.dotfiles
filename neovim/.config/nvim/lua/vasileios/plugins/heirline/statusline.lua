local colors = require("vasileios.globals.colors")

local C = require("vasileios.plugins.heirline.components")

return {
   hl = { bg = colors.black },

   C.Mode,
   C.Space(),

   C.WorkingDirectory,
   C.Space(),
   C.GitStatus,

   { provider = "%<" }, -- cut here if not enough space

   { provider = "%=" }, -- right justify
   C.Sessions,

   { provider = "%=" }, -- right justify

    C.LspStatus,
    C.Space(2),
    C.LazyStatus,
    C.Space(2),

    C.SpellIndicator,
    C.Space(2),

    C.FileType,

    C.Ruler,
    C.SearchCount,
}

