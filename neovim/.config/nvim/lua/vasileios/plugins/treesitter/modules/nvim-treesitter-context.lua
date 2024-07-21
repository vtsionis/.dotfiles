local keys = require("vasileios.config.keymaps").treesitter_context

return {
   "nvim-treesitter/nvim-treesitter-context",
   event = {
      "BufReadPost",
      "BufNewFile",
      "VeryLazy",
   },
   keys = keys or {},
   config = function()
      require("treesitter-context").setup({
         max_lines = 2,
      })
   end
}

