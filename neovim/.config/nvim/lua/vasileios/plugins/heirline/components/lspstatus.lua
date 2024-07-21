local colors = require("vasileios.globals.colors")

local conditions = require("heirline.conditions")

return {
    condition = conditions.lsp_attached,

    update = {
        "LspAttach",
        "LspDetach",
    },

    hl = { fg = colors.cyan },

    on_click = {
       name = "heirline_lsp_status",

       callback = function()
          vim.cmd("LspInfo")
       end,
    },

    provider = function()
        local names = {}
        for _, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
            table.insert(names, server.name)
        end
        return " [" .. table.concat(names, " ") .. "]"
    end,
}

