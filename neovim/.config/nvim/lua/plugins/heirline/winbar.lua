local colors = require("utils.colors")

local C = require("plugins.heirline.components")

return {
    init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
    end,

    hl = { bg = colors.dark_grey },

    C.Space(),
    C.FileIcon,
    C.Space(),
    C.FileName,
    C.Space(),
    C.FileFlags,
    C.Space(),

    { provider = "%=" },
    C.CloseButton,
}

