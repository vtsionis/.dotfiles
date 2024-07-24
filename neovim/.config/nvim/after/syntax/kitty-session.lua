if vim.fn.exists(vim.b.current_syntax) then
   return
end

vim.cmd([[syn match kittyKW '^\S*' contains=kittySessionCommand,kittyInvalidKeyword]])
vim.cmd([[syn match kittyInvalidKeyword '\S*' contained]])
vim.cmd([[syn match kittyComment /^\s*#.*$/ contains=kittyTodo]])
vim.cmd([[syn region kittyString start=+"+ skip=+\\\\\|\\"+ end=+"+ oneline]])
vim.cmd([[syn region kittyString start=+'+ skip=+\\\\\|\\'+ end=+'+ oneline]])
vim.cmd([[syn keyword kittyTodo contained TODO FIXME XXX contained]])

vim.cmd([[syn keyword kittySessionCommand
	\ new_tab
	\ new_os_window
	\ layout
	\ launch
	\ focus
	\ enabled_layouts
	\ cd
	\ title
	\ os_window_size
	\ os_window_class]])

vim.cmd([[hi def link kittySessionCommand Keyword]])
vim.cmd([[hi def link kittyComment Comment]])
vim.cmd([[hi def link kittyTodo	Todo]])
vim.cmd([[hi def link kittyInvalidKeyword Error]])
vim.cmd([[hi def link kittyString String]])

