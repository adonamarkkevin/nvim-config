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

-- Prevent E138: wipe stale ShaDa tmp files on startup
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        local shada_dir = vim.fn.stdpath("state") .. "/shada"
        for _, f in ipairs(vim.fn.glob(shada_dir .. "/main.shada.tmp.*", false, true)) do
            vim.fn.delete(f)
        end
    end,
})

-- Neovim 0.12 built-in treesitter crashes on markdown injection parsing
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.treesitter.stop()
    end,
})
