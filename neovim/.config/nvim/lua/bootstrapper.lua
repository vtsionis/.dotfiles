local M = {
	initialized = false,
}

M.init = function()
	if not M.initialized then
		M.initialized = true

		require("config.options")
        require("manager.lazy")
	end
end

M.setup = function()
    vim.api.nvim_create_autocmd("User", {
        group = vim.api.nvim_create_augroup("UserConfig", { clear = true }),
        pattern = "VeryLazy",
        callback = function()
            require("config.autocommands")
            require("config.keymaps").setup()

            -- Load custom highlights after the color scheme is set so they will
            -- not get overwritten by the color scheme
            require("config.highlights")
        end,
    })

end

return M

