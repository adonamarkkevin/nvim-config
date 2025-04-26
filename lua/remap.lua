-- leader key
vim.g.mapleader = " "

-- save using ctrl + s
vim.api.nvim_set_keymap("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })

-- save using ctrl + s
vim.api.nvim_set_keymap("n", "<leader>h", ":buffer #<CR>", { noremap = true, silent = true })

-- toggle relative line numbers
vim.api.nvim_set_keymap("n", "<leader>rn", ":set relativenumber!<CR>", { noremap = true, silent = true })

-- exit insert
vim.api.nvim_set_keymap("i", "<C-c>", "<Esc>", { noremap = true })

-- exit visual
vim.api.nvim_set_keymap("v", "<C-c>", "<Esc>", { noremap = true })

-- remove highlight
vim.api.nvim_set_keymap("n", "<Esc>", ":noh<CR>", { noremap = true, silent = true })

-- open new window right
vim.api.nvim_set_keymap("n", "<leader>wr", ":botright vnew<CR>", { noremap = true, silent = true })

-- exit vim with 2 ctrl-c
local ctrl_c_pressed = 0

function HandleCtrlCExit()
    if ctrl_c_pressed == 0 then
        ctrl_c_pressed = 1
        vim.cmd('echo "Press <C-c> again to exit, or any other key to cancel."')
        return
    end

    ctrl_c_pressed = 0
    vim.cmd("confirm quit")
end

vim.api.nvim_set_keymap("n", "<C-c>", ":lua HandleCtrlCExit()<CR>", { noremap = true, silent = true })
