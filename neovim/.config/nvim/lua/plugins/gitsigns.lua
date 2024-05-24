local git_icons = require("utils.icons").git

return {
    "lewis6991/gitsigns.nvim",
    opts = {
        signs = {
            add = { text = git_icons.add },
            change = { text = git_icons.change },
            delete = { text = git_icons.delete },
            topdelete = { text = git_icons.todelete },
            changedelete = { text = git_icons.changedelete },
            untracked = { text = git_icons.untracked },
        },
    },
    lazy = false,
}

