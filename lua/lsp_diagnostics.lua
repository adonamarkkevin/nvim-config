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
