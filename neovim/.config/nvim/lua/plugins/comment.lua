return {
    "numToStr/Comment.nvim",
    opts = {
        -- Add a space b/w comment and the line
        padding = true,

        -- Wether the cursor should stay at its position
        sticky = true,

        -- Lines to be ignored while (un)commenting
        ignore = nil,
        -- ignore = "^$", -- empty lines

        -- LHS of toggle mappings in NORMAL mode
        toggler = {
            -- Line-comment toggle keymap
            line = "gcc",

            -- Block-comment toggle keymap
            block = "gbc",
        },

        -- LHS of operator-pending mappings in NORMAL and VISUAL mode
        opleader = {
            -- Line-comment keymap
            line = "gc",

            -- Block-comment keymap
            block = "gb",
        },

        -- LHS of extra mappings
        extra = {
            -- Add comment on the line above
            above = "gcO",

            -- Add comment on the line below
            below = "gco",

            -- Add comment at the end of line
            eol = "gcA",
        },

        -- Enable keybindings
        -- NOTE: If given `false` then the plugin won"t create any mappings
        mappings = {
            -- Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}`
            -- `gb[count]{motion}`
            basic = true,

            -- Extra mapping; `gco` `gcO` `gcA`
            extra = true,
        },

        -- Function to call before (un)comment
        pre_hook = function(ctx)
            local U = require("Comment.utils")

            -- Determine whether to use linewise or blockwise commentstring
            local type = ctx.ctype == U.ctype.linewise and "__default" or "__multiline"

            -- Determine the location where to calculate commentstring from
            local location = nil
            if ctx.ctype == U.ctype.blockwise then
                location = {
                    ctx.range.srow - 1,
                    ctx.range.scol,
                }
            elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
                location = require("ts_context_commentstring.utils").get_visual_start_location()
            end

            return require("ts_context_commentstring").calculate_commentstring {
                key = type,
                location = location,
            }
        end,

        -- Function to call after (un)comment
        post_hook = nil,
    },
    lazy = false,
}

