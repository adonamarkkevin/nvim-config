-- leader key
vim.g.mapleader = " "

-- tab width
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

-- save using ctrl + s
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })

-- toggle relative line numbers
vim.api.nvim_set_keymap('n', '<leader>rn', ':set relativenumber!<CR>', { noremap = true, silent = true })

-- exit insert
vim.api.nvim_set_keymap('i', '<C-c>', '<Esc>', { noremap = true })

-- exit visual
vim.api.nvim_set_keymap('v', '<C-c>', '<Esc>', { noremap = true })

-- remove highlight
vim.api.nvim_set_keymap('n', '<Esc>', ':noh<CR>', {noremap = true, silent = true})
