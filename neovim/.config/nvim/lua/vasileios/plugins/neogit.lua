return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",

    "nvim-telescope/telescope.nvim",
  },
  cmd = {
     "Neogit",
  },
  opts = {
     disable_insert_on_commit = true,
     graph_style = "unicode",
     commit_editor = {
        kind = "split",
     },
     integrations = {
        telescope = true,
        diffview = true,
     },
  },
}

