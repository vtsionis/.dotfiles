return {
   "hrsh7th/nvim-cmp",
   event = "InsertEnter",
   dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",

      {
         "L3MON4D3/LuaSnip",
         version = "v2.*",
         build = "make install_jsregexp",
      },
      "saadparwaiz1/cmp_luasnip",

      "onsails/lspkind.nvim",
   },
   config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      lspkind.init()

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
         enabled = function()
            -- disable completion in comments
            local context = require("cmp.config.context")
            -- keep command mode completion enabled when cursor is in a comment
            if vim.api.nvim_get_mode().mode == "c" then
               return true
            end

            return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
         end,

         mapping = cmp.mapping.preset.insert({
            ["<C-Space>"] = cmp.mapping.complete(), -- Open completion window
            ["<C-e>"] = cmp.mapping.abort(), -- Close completion window

            ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
            ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
            ["<C-y>"] = cmp.mapping(cmp.mapping.confirm({
               behavior = cmp.ConfirmBehavior.Insert,
               select = true,
            }), { "i" }),

            ["<C-u>"] = cmp.mapping.scroll_docs(-4),
            ["<C-d>"] = cmp.mapping.scroll_docs(4),

            ["<C-l>"] = cmp.mapping(function()
               if luasnip.expand_or_locally_jumpable() then
                  luasnip.expand_or_jump()
               end
            end, { "i", "s" }),
            ["<C-h>"] = cmp.mapping(function()
               if luasnip.locally_jumpable(-1) then
                  luasnip.jump(-1)
               end
            end, { "i", "s" }),
         }),

         completion = {
            completeopt = "menu,menuone,preview,noselect",
         },

         snippet = {
            expand = function(args)
               luasnip.lsp_expand(args.body)
            end,
         },

         sources = {
            { name = "luasnip" },
            { name = "nvim_lua" },
            { name = "nvim_lsp" },
            { name = "path" },
            { name = "buffer" },
         },

         formatting = {
            format = lspkind.cmp_format({
               maxwidth = 50,
               ellipsis_char = "...",
            }),
         },
      })

      for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/vasileios/plugins/completion/snippets/*.lua", true)) do
         loadfile(ft_path)()
      end
   end,
}

