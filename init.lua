local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)


-- Set Neovim tab settings
vim.opt.tabstop = 4      -- Number of spaces that a <Tab> in the file counts for
vim.opt.shiftwidth = 4   -- Number of spaces to use for each step of (auto)indent
vim.opt.expandtab = true -- Convert tabs to spaces


vim.opt.clipboard = "unnamedplus" -- can copy and paste outside vim

vim.opt.number = true             -- Show absolute line numbers


-- limit code to 80 char horizontally
vim.opt.textwidth = 80            -- Set maximum width of text to 80 characters
vim.opt.wrap = true               -- Enable line wrapping
vim.opt.linebreak = true          -- Wrap lines at convenient points (like spaces)
vim.opt.formatoptions:append('t') -- Automatically wrap text when typing beyond 80 characters
vim.opt.colorcolumn = "80"        -- Display a vertical line at the 80-character mark

require("remap")
require("lazy").setup("plugins")