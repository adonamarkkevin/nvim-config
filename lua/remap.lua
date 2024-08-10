vim.g.mapleader = " " --leader key

vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true }) -- save using ctrl + s

-- toggle relative line numbers
vim.api.nvim_set_keymap('n', '<leader>rn', ':set relativenumber!<CR>', { noremap = true, silent = true })
