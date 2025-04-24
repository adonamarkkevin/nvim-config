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

vim.opt.clipboard = "unnamedplus" -- can copy and paste outside vim

vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.number = true -- Show absolute line number on the current line

-- limit code to 80 char horizontally
vim.opt.textwidth = 80 -- Set maximum width of text to 80 characters
vim.opt.wrap = true -- Enable line wrapping
vim.opt.linebreak = true -- Wrap lines at convenient points (like spaces)
vim.opt.formatoptions:append("t") -- Automatically wrap text when typing beyond 80 characters
vim.opt.colorcolumn = "80" -- Display a vertical line at the 80-character mark

-- Diagnostic error width max at 80
vim.diagnostic.config({
    virtual_text = {
        source = "if_many",
        format = function(diagnostic)
            local max_len = 60
            local msg = diagnostic.message
            if #msg > max_len then
                return msg:sub(1, max_len) .. "…"
            end
            return msg
        end,
    },
    float = {
        source = "always",
        border = "rounded",
        max_width = 100,
        focusable = true,
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

-- Diagnostic hover error display
vim.o.updatetime = 250
vim.cmd([[
  autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})
]])

require("remap")
require("lazy").setup("plugins")
