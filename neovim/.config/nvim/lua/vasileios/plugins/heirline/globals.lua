local M = {}

M.disabled_filetypes = {
   "lazy",
   "lspinfo",
   "man",
   "mason",
   "NvimTree",
   "TelescopePrompt",
   "TelescopeResults",
   "WhichKey",
}

M.winbar_disabled_filetypes = vim.tbl_deep_extend("force", M.disabled_filetypes, {
   "toggleterm",
})

return M

