-- NOTE: This plugin provides support for lorem ipsum text by typing "lorem"
-- and then expand with the emmet leader key and ",". A number can be specified
-- with i.e. lorem20.

return {
    "mattn/emmet-vim",
    event = "VeryLazy",
    init = function()
        vim.g.user_emmet_leader_key = ","
        vim.g.user_emmet_install_global = false
        vim.g.user_emmet_mode = "i"

    end,
    config = function()
        vim.api.nvim_create_autocmd("FileType", {
            pattern = {
                "html",
                "css",
            },
            command = vim.cmd([[EmmetInstall]]),
        })
    end,
}

