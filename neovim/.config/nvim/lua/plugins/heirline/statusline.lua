local colors = require("utils.colors")

local utils = require("heirline.utils")

local separators = require("plugins.heirline.config").separators
local C = require("plugins.heirline.components")

return {
    hl = { bg = colors.black },

    C.Mode,
    C.Space(),

    C.WorkingDirectory,
    C.Space(),
    C.GitStatus,
    C.Space(),

    { provider = "%<" }, -- cut here if not enough space

    { provider = "%=" }, -- right justify

    C.Diagnostics,
    C.Space(4),

    C.LspStatus,
    C.Space(),

    C.LazyStatus,
    C.Space(),

    C.SpellIndicator,
    C.Space(2),

    {
        utils.surround({
            separators.bubble_left,
            separators.bubble_right,
        }, colors.blue, {
            hl = { fg = colors.white },
            C.FileType,
        }),

        C.FileAttributes,
    },

    C.Space(2),
    C.Ruler,

    C.SearchCount,
}

