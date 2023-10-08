-- NOTE: This plugin provides support for lorem ipsum text by typing "lorem"
-- and then expand with the emmet leader key and ",". A number can be specified
-- with i.e. lorem20.

return {
    "mattn/emmet-vim",
    ft = {
        "html",
        "css",
    },
    init = function()
        vim.g.user_emmet_leader_key = ","
        vim.g.user_emmet_mode = "i"

        local snippets_file = vim.fn.stdpath "config" .. "/lua/plugins/emmet/snippets.json"
        local snippets = table.concat(vim.fn.readfile(snippets_file), "\n")
        vim.g.user_emmet_settings = vim.json.decode(snippets)
    end,
}

