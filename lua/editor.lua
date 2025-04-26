-- tab width
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

vim.opt.clipboard = "unnamedplus" -- can copy and paste outside vim

vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.number = true -- Show absolute line number on the current line

-- limit code to 80 char horizontally
vim.opt.textwidth = 80 -- Set maximum width of text to 80 characters
vim.opt.wrap = true -- Enable line wrapping
vim.opt.linebreak = true -- Wrap lines at convenient points (like spaces)
vim.opt.formatoptions:append("t") -- Automatically wrap text when typing beyond 80 characters
vim.opt.colorcolumn = "80" -- Display a vertical line at the 80-character mark
